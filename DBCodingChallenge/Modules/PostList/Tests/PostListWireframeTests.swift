//
//  PostListWireframeTests.swift
//  DBCodingChallengeTests
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import XCTest
@testable import DBCodingChallenge

class PostListWireframeTests: XCTestCase {
    class MockWireframe: WireframeProtocol {
        func start(in window: UIWindow?, on navigationController: UINavigationController?) {}
    }
    
    class MockUserClient: UserClientProtocol {
        func fetchUserWith(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {}
    }
    
    var sut: PostListWireframe!

    override func setUpWithError() throws {
        sut = PostListWireframe()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testStartShowsLoginViewController() throws {
        let window = UIWindow()
        let postListViewController = PostListViewController(postListInteractor: PostListInteractor(postListPresenter: PostListPresenter()))
        sut.postListViewController = postListViewController
        sut.start(in: window, on: nil)
        
        let navController = window.rootViewController as? UINavigationController
        XCTAssertTrue(postListViewController === navController?.viewControllers[0])
    }
}
