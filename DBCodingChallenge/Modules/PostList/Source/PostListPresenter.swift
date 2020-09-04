//
//  PostListPresenter.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol PostListPresenterProtocol {
    func presentFetchedPosts(_ posts: [Post], favoritePostIds: Set<Int>)
}

class PostListPresenter: PostListPresenterProtocol {
    weak var postListView: PostListView?
    
    func presentFetchedPosts(_ posts: [Post], favoritePostIds: Set<Int>) {
        let postViewModels = posts.map {
            PostViewModel(id: $0.id, title: $0.title, body: $0.body, favorite: favoritePostIds.contains($0.id))
        }
        postListView?.update(postViewModels: postViewModels)
    }
}
