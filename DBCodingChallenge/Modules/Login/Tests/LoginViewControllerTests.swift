//
//  LoginViewControllerTests.swift
//  DBCodingChallengeTests
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import XCTest
@testable import DBCodingChallenge

class LoginViewControllerTests: XCTestCase {
    var sut: LoginViewController!
    var mockLoginInteractor: MockLoginInteractor!
    
    class MockLoginInteractor: LoginInteractorProtocol {
        var loginWasCalledWithUserId: Int = 0
        
        func login(with userId: Int) {
            loginWasCalledWithUserId = userId
        }
    }
    
    override func setUpWithError() throws {
        mockLoginInteractor = MockLoginInteractor()
        sut = LoginViewController(loginInteractor: mockLoginInteractor)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoginButtonTappedWithInvalidUserIdDoesNotTriggerInteractor() throws {
        sut.userIdTextField.text = "test"
        sut.loginButtonTapped()
        
        XCTAssertEqual(mockLoginInteractor.loginWasCalledWithUserId, 0)
        XCTAssertEqual(sut.loginFeedbackLabel.text, "Eingabe inkorrekt")
    }
    
    func testLoginButtonTappedWithPossiblyValidUserIdTriggersInteractor() throws {
        sut.userIdTextField.text = "1"
        sut.loginButtonTapped()
        
        XCTAssertEqual(mockLoginInteractor.loginWasCalledWithUserId, 1)
        XCTAssertEqual(sut.loginFeedbackLabel.text, nil)
    }
    
    func testShowLoginSucceededShowsUserName() throws {
        let userViewModel = DBCodingChallenge.UserViewModel(name: "Name", username: "Username")
        sut.showLoginSucceeded(with: userViewModel)
        
       XCTAssertEqual(sut.loginFeedbackLabel.text, "Login erfolgreich, hallo Name")
    }

    func testShowLoginFailedShowsLoginFailedMessage() throws {
        sut.showLoginFailed()
        
        XCTAssertEqual(sut.loginFeedbackLabel.text, "Login fehlgeschagen")
    }
}
