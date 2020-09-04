//
//  PostListViewControllerTests.swift
//  DBCodingChallengeTests
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import XCTest
@testable import DBCodingChallenge

class PostListViewControllerTests: XCTestCase {
    class MockPostListInteractor: PostListInteractorProtocol {
        var fetchPostsWasCalledWithUser: User?
        var togglePostsWasCalledWithId: Int?
        
        func fetchPosts(for user: User) {
            fetchPostsWasCalledWithUser = user
        }
        
        func toggleFavoriteForPost(with id: Int) {
            togglePostsWasCalledWithId = id
        }
    }
    
    var sut: PostListViewController!

    override func setUpWithError() throws {
        sut = PostListViewController(postListInteractor: MockPostListInteractor())
        
        sut.postViewModels = [
            PostListPostViewModel(
                id: 2,
                title: "Post 1",
                body: "Body 1",
                favorite: false
            ),
            PostListPostViewModel(
                id: 17,
                title: "Post 2",
                body: "Body 2",
                favorite: true
            )
        ]
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testTableViewUpdatesAfterFavoriteFilterToggled() throws {
        let mockTableView = MockTableView()
        let expectation = XCTestExpectation(description: "reload data was called")
        mockTableView.expectation = expectation
        sut.tableView = mockTableView
        
        XCTAssertFalse(sut.showOnlyFavorites)
        
        sut.toggleShowOnlyFavoritesButtonPressed(button: sut.showOnlyFavoritesButton)
        
        XCTAssertTrue(sut.showOnlyFavorites)
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue((sut.tableView as! MockTableView).reloadDataWasCalled)
    }
    
    func testShowOnlyFavoritesWhenFilterIsActive() {
        let numberOfRowsWhenFilterOff = sut.tableView(sut.tableView,
            numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRowsWhenFilterOff, 2)
        
        sut.showOnlyFavorites = true
        
        let numberOfRowsWhenFilterOn = sut.tableView(sut.tableView,
            numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRowsWhenFilterOn, 1)
    }

    func testPostsGetFetchedOnViewWillAppear() {
        CurrentUser.shared.user = User(id: 25, name: "name", username: "username")
        sut.viewWillAppear(false)
        
        let mockPostListInteractor = sut.postListInteractor as! MockPostListInteractor
        XCTAssertEqual(mockPostListInteractor.fetchPostsWasCalledWithUser!.id, 25)
    }
    
    func testToggleFavoriteTriggersToggleFavoriteOnInteractor() {
        let button = UIButton()
        button.tag = 22
        sut.toggleFavoriteButtonPressed(button: button)
        
        XCTAssertEqual((sut.postListInteractor as! MockPostListInteractor).togglePostsWasCalledWithId!, 22)
    }
}
