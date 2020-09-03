//
//  LoginInteractor.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol LoginInteractorProtocol {
    func login(with userId: Int)
}

class LoginInteractor: LoginInteractorProtocol {
    let loginPresenter: LoginPresenterProtocol
    let userClient: UserClientProtocol
    
    init(loginPresenter: LoginPresenterProtocol, userClient: UserClientProtocol = JPHUserClient()) {
        self.loginPresenter = loginPresenter
        self.userClient = userClient
    }
    
    func login(with userId: Int) {
        userClient.fetchUserWith(userId: userId) { [weak self] result in
            switch result {
            case .success(let user):
                // TODO: save user "credentials"
                self?.loginPresenter.loginSucceeded(with: user)
            case .failure(let error):
                print(error)
                self?.loginPresenter.loginFailed()
            }
        }
    }
}
