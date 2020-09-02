//
//  LoginWireframeTests.swift
//  DBCodingChallengeTests
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import XCTest
@testable import DBCodingChallenge

class LoginWireframeTests: XCTestCase {
    var sut: LoginWireframe!

    override func setUpWithError() throws {
        sut = LoginWireframe()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testStartShowsLoginViewController() throws {
        let window = UIWindow()
        
        let loginViewController = LoginViewController(loginInteractor: LoginInteractor(loginPresenter: LoginPresenter(), userClient: JPHUserClient()))
        sut.loginView = loginViewController
        sut.start(in: window)
        XCTAssertTrue(loginViewController === window.rootViewController!)
    }
}
