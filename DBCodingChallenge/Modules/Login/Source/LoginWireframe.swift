//
//  LoginWireframe.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol LoginWireframeProtocol {
    func start(in window: UIWindow?)
}

class LoginWireframe: LoginWireframeProtocol {
    var loginView: LoginViewProtocol?
    
    func start(in window: UIWindow?) {
        window?.rootViewController = loginView
        window?.makeKeyAndVisible()
    }
}
