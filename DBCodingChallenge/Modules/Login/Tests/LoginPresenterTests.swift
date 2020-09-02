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
    var loginView: LoginViewProtocol!
    
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
        loginView = LoginViewController(loginInteractor: LoginInteractor(loginPresenter: sut, userClient: JPHUserClient()))
        sut.loginView = loginView
    }

    override func tearDownWithError() throws {
        sut = nil
        loginView = nil
    }
    
    func testLoginSuccededShowsUserName() throws {
        sut.loginSucceeded(with: User(id: 1, name: "Name", username: "Username"))
        
        XCTAssertEqual((loginView as! LoginViewController).loginFeedbackLabel.text, "Login erfolgreich. Hallo Name")
    }

    func testLoginFailed() throws {
        sut.loginFailed()
        
        XCTAssertEqual((loginView as! LoginViewController).loginFeedbackLabel.text, "Login fehlgeschagen")
    }
}
