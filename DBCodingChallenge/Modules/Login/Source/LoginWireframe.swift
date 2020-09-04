//
//  LoginWireframe.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol LoginWireframeProtocol: WireframeProtocol {}

class LoginWireframe: LoginWireframeProtocol {
    var wireframeAfterLogin: WireframeProtocol?
    weak var loginViewController: LoginViewController?
    
    private func createLoginViewController() -> LoginViewController {
        let loginPresenter = LoginPresenter()
        let loginInteractor = LoginInteractor(loginPresenter: loginPresenter)
        let loginViewController = LoginViewController(loginInteractor: loginInteractor)
        loginViewController.wireframe = self
        loginPresenter.loginView = loginViewController
        
        return loginViewController
    }
    
    func start(in window: UIWindow?, on navigationController: UINavigationController? = nil) {
        window?.rootViewController = self.loginViewController ?? self.createLoginViewController()
        window?.makeKeyAndVisible()
    }
}
