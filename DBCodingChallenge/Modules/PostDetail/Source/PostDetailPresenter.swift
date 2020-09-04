//
//  PostDetailPresenter.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol PostDetailPresenterProtocol {
    func present(post: PostListPostViewModel, and comments: [Comment])
}

class PostDetailPresenter: PostDetailPresenterProtocol {
    weak var postDetailView: PostDetailView?
    
    func present(post: PostListPostViewModel, and comments: [Comment]) {
        postDetailView?.update(with: PostDetailViewModel(id: post.id, title: post.title, body: post
            .body, favorite: post.favorite), and: [])
    }
}
