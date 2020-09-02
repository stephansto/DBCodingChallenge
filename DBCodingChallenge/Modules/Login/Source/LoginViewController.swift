//
//  LoginViewController.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol LoginViewProtocol: UIViewController {
    
}

class LoginViewController: UIViewController, LoginViewProtocol {
    let loginInteractor: LoginInteractorProtocol
    
    init(loginInteractor: LoginInteractorProtocol) {
        self.loginInteractor = loginInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }
}
