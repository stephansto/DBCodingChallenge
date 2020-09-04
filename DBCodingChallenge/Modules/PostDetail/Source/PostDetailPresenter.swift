//
//  PostDetailPresenter.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol PostDetailPresenterProtocol {
    func present(comments: [Comment])
}

class PostDetailPresenter: PostDetailPresenterProtocol {
    weak var postDetailView: PostDetailView?
    
    func present(comments: [Comment]) {
        postDetailView?.update(with: [])
    }
}
