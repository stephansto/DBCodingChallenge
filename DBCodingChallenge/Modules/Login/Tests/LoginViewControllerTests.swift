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
    class MockWireframe: WireframeProtocol {
        func start(in window: UIWindow?, on navigationController: UINavigationController?) {}
    }
    
    class MockLoginInteractor: LoginInteractorProtocol {
        var loginWasCalledWithUserId: Int = -1
        
        func login(with userId: Int) {
            loginWasCalledWithUserId = userId
        }
    }
    
    var sut: LoginViewController!
    var mockLoginInteractor: MockLoginInteractor!
    
    override func setUpWithError() throws {
        mockLoginInteractor = MockLoginInteractor()
        sut = LoginViewController(loginInteractor: mockLoginInteractor)
        sut.wireframe = MockWireframe()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoginButtonTappedWithInvalidUserIdDoesNotTriggerLoginOnInteractor() throws {
        sut.userIdTextField.text = "test"
        sut.loginButtonTapped()
        
        XCTAssertEqual(mockLoginInteractor.loginWasCalledWithUserId, -1)
    }
    
    func testLoginButtonTappedWithPossiblyValidUserIdTriggersLoginOnInteractor() throws {
        sut.userIdTextField.text = "1"
        sut.loginButtonTapped()
        
        XCTAssertEqual(mockLoginInteractor.loginWasCalledWithUserId, 1)
        XCTAssertEqual(sut.loginFeedbackLabel.text, nil)
    }
}
