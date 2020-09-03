//
//  PostListInteractor.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol PostListInteractorProtocol {
    func fetchPosts(for user: User)
    func toggleFavoriteForPost(with id: Int)
}

class PostListInteractor: PostListInteractorProtocol {
    let postListPresenter: PostListPresenterProtocol
    let postClient: PostClientProtocol
    
    var posts = [Post]()
    var favoritePostIds = Set<Int>()
    
    init(postListPresenter: PostListPresenterProtocol, postClient: PostClientProtocol = JPHPostClient()) {
        self.postListPresenter = postListPresenter
        self.postClient = postClient
    }
    
    func fetchPosts(for user: User) {
        postClient.fetchPosts(for: user) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
                self?.postListPresenter.presentFetchedPosts(posts, favoritePostIds: self?.favoritePostIds ?? [])
            case .failure(let error):
                print(error)
            } 
        }
    }
    
    func toggleFavoriteForPost(with id: Int) {
        _ = favoritePostIds.contains(id) ? favoritePostIds.remove(id) : favoritePostIds.update(with: id)
        postListPresenter.presentFetchedPosts(posts, favoritePostIds: favoritePostIds)
    }
}
