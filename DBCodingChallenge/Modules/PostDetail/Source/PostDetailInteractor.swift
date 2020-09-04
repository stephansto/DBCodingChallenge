//
//  PostDetailInteractor.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol PostDetailInteractorProtocol {
    func fetchComments(for commentId: Int)
}

class PostDetailInteractor: PostDetailInteractorProtocol {
    let postDetailPresenter: PostDetailPresenterProtocol
    let commentClient: CommentClientProtocol
    
    init(postDetailPresenter: PostDetailPresenterProtocol, commentClient: CommentClientProtocol = JHPCommentClient()) {
        self.postDetailPresenter = postDetailPresenter
        self.commentClient = commentClient
    }
    
    func fetchComments(for commentId: Int) {
        commentClient.fetchComments(for: commentId) { [weak self] result in
            switch result {
            case .success(let comments):
                self?.postDetailPresenter.present(comments)
            case .failure(let error):
                print(error)
            }
        }
    }
}
