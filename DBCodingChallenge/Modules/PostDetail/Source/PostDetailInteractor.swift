//
//  PostDetailInteractor.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol PostDetailInteractorProtocol {}

class PostDetailInteractor: PostDetailInteractorProtocol {
    let postDetailPresenter: PostDetailPresenterProtocol
    
    init(postDetailPresenter: PostDetailPresenterProtocol) {
        self.postDetailPresenter = postDetailPresenter
    }
}
