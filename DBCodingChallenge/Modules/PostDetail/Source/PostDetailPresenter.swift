//
//  PostDetailPresenter.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol PostDetailPresenterProtocol {
    func present(_ comments: [Comment])
}

class PostDetailPresenter: PostDetailPresenterProtocol {
    weak var postDetailView: PostDetailView?
    
    func present(_ comments: [Comment]) {
        let commentViewModels = comments.map {
            CommentViewModel(username: $0.name, body: $0.body)
        }
        postDetailView?.update(with: commentViewModels)
    }
}
