//
//  PostDetailWireframe.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol PostDetailWireframeProtocol: WireframeProtocol {}

protocol PostDetailDelegate: class {
    func postIsFavoriteWasChanged(for postId: Int)
}

class PostDetailWireframe: PostDetailWireframeProtocol {
    let postViewModel: PostViewModel
    
    weak var postDetailViewController: PostDetailViewController?
    
    weak var delegate: PostDetailDelegate?
    
    init(postViewModel: PostViewModel) {
        self.postViewModel = postViewModel
    }
    
    private func createPostDetailViewController() -> PostDetailViewController {
        let postDetailPresenter = PostDetailPresenter()
        let postDetailInteractor = PostDetailInteractor(postDetailPresenter: postDetailPresenter)
        let postDetailViewController = PostDetailViewController(postDetailInteractor: postDetailInteractor, postViewModel: postViewModel)
        postDetailViewController.wireframe = self
        postDetailPresenter.postDetailView = postDetailViewController
        
        return postDetailViewController
    }
    
    func start(in window: UIWindow?, on navigationController: UINavigationController?) {
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(self.postDetailViewController ?? self.createPostDetailViewController(), animated: true)
    }
    
//    private func 
}
