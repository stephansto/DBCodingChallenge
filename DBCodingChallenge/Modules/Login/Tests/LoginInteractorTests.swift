//
//  LoginInteractorTests.swift
//  DBCodingChallengeTests
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import XCTest
@testable import DBCodingChallenge

class LoginInteractorTests: XCTestCase {
    var sut: LoginInteractor!
    var mockLoginPresenter: MockLoginPresenter!
    
    let expectation = XCTestExpectation(description: "TestExoectation")
    
    class MockLoginPresenter: LoginPresenterProtocol {
        var loginSucceededWasCalledWithUser: User? = nil
        var loginFailedWasCalled = false
        
        let expectation: XCTestExpectation
        
        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }
        
        func loginSucceeded(with user: User) {
            loginSucceededWasCalledWithUser = user
            expectation.fulfill()
        }
        
        func loginFailed() {
            loginFailedWasCalled = true
            expectation.fulfill()
        }
    }
    
    class MockUserClient: UserClientProtocol {
        enum TestError: Error {
            case test
        }
        
        func fetchUserWith(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
            if userId == 1 {
                completion(.success(User(id: 1, name: "Name", username: "Username")))
            } else {
                completion(.failure(TestError.test))
            }
        }
    }

    override func setUpWithError() throws {
        mockLoginPresenter = MockLoginPresenter(expectation: expectation)
        sut = LoginInteractor(loginPresenter: mockLoginPresenter, userClient: MockUserClient())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoginSucceededReturnsUser() throws {
        sut.login(with: 1)
        
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(mockLoginPresenter.loginSucceededWasCalledWithUser!.id, 1)
    }

    func testLoginFailedTriggersLoginFailedOnPresenter() throws {
        sut.login(with: 999)
        
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(mockLoginPresenter.loginFailedWasCalled, true)
    }
}
