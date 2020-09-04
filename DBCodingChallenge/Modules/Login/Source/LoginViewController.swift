//
//  LoginViewController.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol LoginViewProtocol: class {
    func showLoginSucceeded(with userViewModel: UserViewModel)
    func showLoginFailed()
}

class LoginViewController: UIViewController {
    let loginInteractor: LoginInteractorProtocol
    let wireframe: WireframeProtocol
    
    let verticalStackView = UIStackView()
    let horizontalStackView = UIStackView()
    let innerVerticalStackView = UIStackView()
    let userIdLabel = UILabel()
    let userIdTextField = UITextField()
    let userIdTextFieldBorder = UIView()
    var loginButton = UIButton()
    let loginFeedbackLabel = UILabel()
    
    var bottomConstraint: NSLayoutConstraint!
    
    init(loginInteractor: LoginInteractorProtocol, wireframe: WireframeProtocol) {
        self.loginInteractor = loginInteractor
        self.wireframe = wireframe
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        unregisterFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Default.primaryBackground
        
        registerForKeyboardNotifications()
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    private func setupHierarchy() {
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(UIView())
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(loginButton)
        verticalStackView.addArrangedSubview(UIView())
        verticalStackView.addArrangedSubview(loginFeedbackLabel)
        
        horizontalStackView.addArrangedSubview(userIdLabel)
        horizontalStackView.addArrangedSubview(innerVerticalStackView)
        
        innerVerticalStackView.addArrangedSubview(userIdTextField)
        innerVerticalStackView.addArrangedSubview(userIdTextFieldBorder)
    }
    
    private func setupViews() {
        userIdLabel.text = "UserId:"
        userIdLabel.font = .systemFont(ofSize: 20)
        userIdLabel.textColor = UIColor.Default.primaryText
        
        userIdTextField.font = .systemFont(ofSize: 20)
        userIdTextField.textColor = UIColor.Default.primaryText
        userIdTextField.clearButtonMode = .whileEditing
        userIdTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)

        userIdTextFieldBorder.backgroundColor = UIColor.Default.border
        
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 28)
        loginButton.setTitleColor(UIColor.Default.primaryText, for: .normal)
        loginButton.setTitleColor(UIColor.Default.inactive, for: .disabled)
        loginButton.backgroundColor = UIColor.Default.tint
        loginButton.isEnabled = false
        loginButton.addTarget(self, action:
            #selector(loginButtonTapped), for: .touchUpInside)
        
        loginFeedbackLabel.font = .systemFont(ofSize: 14)
        loginFeedbackLabel.textColor = UIColor.Default.primaryText
        loginFeedbackLabel.textAlignment = .center
    }
    
    private func setupLayout() {
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .equalCentering
        
        horizontalStackView.distribution = .fillEqually
        
        innerVerticalStackView.axis = .vertical
        
        [verticalStackView, horizontalStackView, userIdLabel, innerVerticalStackView, userIdTextField, userIdTextFieldBorder, loginButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        userIdTextFieldBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        bottomConstraint = verticalStackView.pinToSuperView(constant: 25).bottomConstraint
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            return
        }
        adaptVisibileAreaHeight(by: -keyboardFrame.height)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else {
                return
        }
        adaptVisibileAreaHeight(by: keyboardFrame.height)
    }
    
    private func adaptVisibileAreaHeight(by heightChange: CGFloat) {
        UIView.animate(withDuration: 0.5, animations: {
            if let bottomConstraint = self.bottomConstraint {
                bottomConstraint.constant += heightChange
            } else {
                self.view.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height + heightChange)
            }
        })
    }
    
    private func showInvalidInputMessage(_ show: Bool) {
        loginFeedbackLabel.text = show ? "Eingabe ungültig." : ""
    }
    
    @objc func loginButtonTapped() {
        if let userIdText = userIdTextField.text,
            let userId = Int(userIdText) {
            loginInteractor.login(with: userId)
        }
    }
    
    private func isPossiblyValid(userIdText: String) -> Bool {
        return Int(userIdText) != nil
    }
    
    @objc func navigateToNextScreen() {
        wireframe.start(in: self.view.window, on: nil)
    }
    
    @objc func editingChanged(textField: UITextField) {
        guard let text = textField.text else { return }
        loginButton.isEnabled = text.count > 0 && Int(text) != nil
        showInvalidInputMessage(text.count > 0 && Int(text) == nil)
    }
}

extension LoginViewController: LoginViewProtocol {
    func showLoginSucceeded(with userViewModel: UserViewModel) {
        DispatchQueue.main.async {
            self.loginFeedbackLabel.text = "Login erfolgreich. Hallo \(userViewModel.name)!"

            self.perform(#selector(self.navigateToNextScreen), with: nil, afterDelay: 1)
        }
    }
    
    func showLoginFailed() {
        DispatchQueue.main.async {
            self.loginFeedbackLabel.text = "Login fehlgeschagen"
        }
    }
}
