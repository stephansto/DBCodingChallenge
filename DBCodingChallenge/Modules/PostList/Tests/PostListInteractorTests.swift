//
//  PostListInteractorTests.swift
//  DBCodingChallengeTests
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import XCTest
@testable import DBCodingChallenge

class PostListInteractorTests: XCTestCase {
    class MockPostClient: PostClientProtocol {
        var posts = [Post]()
        
        func fetchPosts(for user: User, completion: @escaping (Result<[Post], Error>) -> Void) {
            completion(.success(posts))
        }
    }
    
    class MockPostListPresenter: PostListPresenterProtocol {
        var presentFetchedPostsWasCalledWithPosts = [Post]()
        var presentFetchedPostsWasCalledWithFavoritePostIds = Set<Int>()
        
        func presentFetchedPosts(_ posts: [Post], favoritePostIds: Set<Int>) {
            presentFetchedPostsWasCalledWithPosts = posts
            presentFetchedPostsWasCalledWithFavoritePostIds = favoritePostIds
        }
    }
    
    var sut: PostListInteractor!
    let mockPostData = [
        Post(
            userId: 1,
            id: 2,
            title: "title",
            body: "body"
        ),
        Post(
            userId: 7,
            id: 5,
            title: "title 2",
            body: "body 2"
        )
    ]

    override func setUpWithError() throws {
        let mockPostClient = MockPostClient()
        mockPostClient.posts = mockPostData
        sut = PostListInteractor(postListPresenter: MockPostListPresenter(), postClient: mockPostClient)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchPostSendsPostToPresenter() throws {
        sut.fetchPosts(for: User(id: 0, name: "", username: ""))
        
        XCTAssertEqual((sut.postListPresenter as! MockPostListPresenter).presentFetchedPostsWasCalledWithPosts[1].id, 5)
    }
    
    func testToggleFavoriteTriggersPresenterWithToggledFavorite() {
        sut.posts = mockPostData
        sut.favoritePostIds = [2, 5]
        sut.toggleFavoriteForPost(with: 5)
        
        XCTAssertEqual((sut.postListPresenter as! MockPostListPresenter).presentFetchedPostsWasCalledWithFavoritePostIds, [2])
    }
}
