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
    class MockWireframe: WireframeProtocol {
        func start(in window: UIWindow?, on navigationController: UINavigationController?) {}
    }
    
    class MockUserClient: UserClientProtocol {
        func fetchUserWith(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {}
    }
    
    var sut: LoginWireframe!

    override func setUpWithError() throws {
        sut = LoginWireframe()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testStartShowsLoginViewController() throws {
        let window = UIWindow()
        let loginViewController = LoginViewController(loginInteractor: LoginInteractor(loginPresenter: LoginPresenter(), userClient: MockUserClient()))
        loginViewController.wireframe = sut
        sut.loginViewController = loginViewController
        sut.start(in: window)
        
        XCTAssertTrue(loginViewController === window.rootViewController!)
    }
}
