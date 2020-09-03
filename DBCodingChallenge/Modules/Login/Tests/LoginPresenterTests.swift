//
//  LoginPresenterTests.swift
//  DBCodingChallengeTests
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import XCTest
@testable import DBCodingChallenge

class LoginPresenterTests: XCTestCase {
    var sut: LoginPresenter!
    var loginView: MockLoginView!
    
    class MockLoginView: LoginViewProtocol {
        var showLoginSuccededWithUserviewModel: UserViewModel? = nil
        var showLoginFailedWasCalled = false

        func showLoginSucceeded(with userViewModel: UserViewModel) {
            showLoginSuccededWithUserviewModel = userViewModel
        }

        func showLoginFailed() {
            showLoginFailedWasCalled = true
        }
    }

    override func setUpWithError() throws {
        sut = LoginPresenter()
        loginView = MockLoginView()
        sut.loginView = loginView
    }

    override func tearDownWithError() throws {
        sut = nil
        loginView = nil
    }
    
    func testLoginSuccededShowsUserName() throws {
        let user = User(id: 1, name: "Name", username: "Username")
        sut.loginSucceeded(with: user)
        
        XCTAssertEqual(loginView.showLoginSuccededWithUserviewModel!.name, user.name)
    }

    func testLoginFailed() throws {
        sut.loginFailed()
        
        XCTAssertTrue(loginView.showLoginFailedWasCalled)
    }
}
