//
//  PostDetailInteractor.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol PostDetailInteractorProtocol {
    func onViewDidLoad()
}

class PostDetailInteractor: PostDetailInteractorProtocol {
    let postDetailPresenter: PostDetailPresenterProtocol
    let postListPostViewModel: PostListPostViewModel
    
    init(postDetailPresenter: PostDetailPresenterProtocol, postListPostViewModel: PostListPostViewModel) {
        self.postDetailPresenter = postDetailPresenter
        self.postListPostViewModel = postListPostViewModel
    }
    
    func onViewDidLoad() {
        fetchComments()
        
        postDetailPresenter.present(post: postListPostViewModel, and: [])
    }
    
    private func fetchComments() {}
    
    
}
