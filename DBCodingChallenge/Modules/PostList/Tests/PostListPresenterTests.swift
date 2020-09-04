//
//  PostListPresenterTests.swift
//  DBCodingChallengeTests
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import XCTest
@testable import DBCodingChallenge

class PostListPresenterTests: XCTestCase {
    class MockPostListView: PostListView {
        var updateWasCalledWithPostViewModels = [PostViewModel]()
        
        func update(postViewModels: [PostViewModel]) {
            updateWasCalledWithPostViewModels = postViewModels
        }
    }
    
    var sut: PostListPresenter!
    var mockPostListView: PostListView?
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
        sut = PostListPresenter()
        mockPostListView = MockPostListView()
        sut.postListView = mockPostListView
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testPresentFetchedPostsUpdatesViewWithViewModels() throws {
        sut.presentFetchedPosts(mockPostData, favoritePostIds: [5])
        
        XCTAssertEqual(
            (sut.postListView as! MockPostListView).updateWasCalledWithPostViewModels,
                       [
            PostViewModel(id: 2, title: "title", body: "body", favorite: false),
            PostViewModel(id: 5, title: "title 2", body: "body 2", favorite: true)
        ])
    }

}
