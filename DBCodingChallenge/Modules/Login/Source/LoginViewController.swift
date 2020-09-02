//
//  LoginViewController.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol LoginViewProtocol: UIViewController {
    func showLoginSucceeded(with userViewModel: UserViewModel)
    func showLoginFailed()
}

class LoginViewController: UIViewController {
    let loginInteractor: LoginInteractorProtocol
    
    let verticalStackView = UIStackView()
    let horizontalStackView = UIStackView()
    let innerVerticalStackView = UIStackView()
    let userIdLabel = UILabel()
    let userIdTextField = UITextField()
    let userIdTextFieldBorder = UIView()
    let loginButton = UIButton()
    let loginFeedbackLabel = UILabel()
    
    var bottomConstraint: NSLayoutConstraint!
    
    init(loginInteractor: LoginInteractorProtocol) {
        self.loginInteractor = loginInteractor
        
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
        
        view.backgroundColor = .orange
        
        registerForKeyboardNotifications()
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    private func setupHierarchy() {
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(UIView())
        verticalStackView.addArrangedSubview(loginButton)
        verticalStackView.addArrangedSubview(loginFeedbackLabel)
        
        horizontalStackView.addArrangedSubview(userIdLabel)
        horizontalStackView.addArrangedSubview(innerVerticalStackView)
        
        innerVerticalStackView.addArrangedSubview(userIdTextField)
        innerVerticalStackView.addArrangedSubview(userIdTextFieldBorder)
    }
    
    private func setupViews() {
        userIdLabel.text = "UserId:"
        userIdLabel.font = .systemFont(ofSize: 20)
        userIdLabel.textColor = .white
        
        userIdTextField.font = .systemFont(ofSize: 20)
        userIdTextField.textColor = .white

        userIdTextFieldBorder.backgroundColor = .white
        
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 28)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        loginFeedbackLabel.font = .systemFont(ofSize: 14)
        loginFeedbackLabel.textColor = .black
    }
    
    private func setupLayout() {
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
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
    
    @objc func loginButtonTapped() {
        print("login button tapped")
        if let userIdText = userIdTextField.text,
            let userId = Int(userIdText) {
            loginInteractor.login(with: userId)
        } else {
            loginFeedbackLabel.text = "Eingabe inkorrekt"
        }
    }
}

extension LoginViewController: LoginViewProtocol {
    func showLoginSucceeded(with userViewModel: UserViewModel) {
        DispatchQueue.main.async {
            self.loginFeedbackLabel.text = "Login erfolgreich. Hallo \(userViewModel.name)!"
        }
    }
    
    func showLoginFailed() {
        DispatchQueue.main.async {
            self.loginFeedbackLabel.text = "Login fehlgeschagen"
        }
    }
}
