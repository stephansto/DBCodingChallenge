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
}

class PostListInteractor: PostListInteractorProtocol {
    let postListPresenter: PostListPresenterProtocol
    let postClient: PostClientProtocol
    
    init(postListPresenter: PostListPresenterProtocol, postClient: PostClientProtocol = JPHPostClient()) {
        self.postListPresenter = postListPresenter
        self.postClient = postClient
    }
    
    func fetchPosts(for user: User) {
        postClient.fetchPosts(for: user) { result in
            switch result {
            case .success(let posts):
                return
            case .failure(let error):
                return
            }
        }
    }
}
