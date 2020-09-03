//
//  LoginWireframe.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol LoginWireframeProtocol: WireframeProtocol {
//    func start(in window: UIWindow?)
}

class LoginWireframe: LoginWireframeProtocol {
    var loginViewController: LoginViewController?
    
    private func createLoginViewController() -> LoginViewController {
        let loginPresenter = LoginPresenter()
        let loginInteractor = LoginInteractor(loginPresenter: loginPresenter)
        let loginViewController = LoginViewController(loginInteractor: loginInteractor, wireframe: PostListWireframe())
        loginPresenter.loginView = loginViewController
        
        return loginViewController
    }
    
    func start(in window: UIWindow?, on navigationController: UINavigationController? = nil) {
        window?.rootViewController = self.loginViewController ?? self.createLoginViewController()
        window?.makeKeyAndVisible()
    }
}
