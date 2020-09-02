//
//  LoginPresenter.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol {
    func loginSucceeded(with user: User)
    func loginFailed()
}

class LoginPresenter: LoginPresenterProtocol {
    weak var loginView: LoginViewProtocol?
    
    func loginSucceeded(with user: User) {
        let userViewModel = UserViewModel(name: user.name, username: user.username)
        loginView?.showLoginSucceeded(with: userViewModel)
    }
    
    func loginFailed() {
        loginView?.showLoginFailed()
    }
}
