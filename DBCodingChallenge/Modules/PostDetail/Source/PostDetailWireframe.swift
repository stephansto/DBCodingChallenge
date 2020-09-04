//
//  PostDetailWireframe.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol PostDetailWireframeProtocol: WireframeProtocol {}

class PostDetailWireframe: PostDetailWireframeProtocol {
    weak var postDetailViewController: PostDetailViewController?
    
    private func createPostDetailViewController() -> PostDetailViewController {
        let postDetailPresenter = PostDetailPresenter()
        let postDetailInteractor = PostDetailInteractor(postDetailPresenter: postDetailPresenter)
        let postDetailViewController = PostDetailViewController(postDetailInteractor: postDetailInteractor)
        postDetailViewController.wireframe = self
        postDetailPresenter.postDetailView = postDetailViewController
        
        return postDetailViewController
    }
    
    func start(in window: UIWindow?, on navigationController: UINavigationController?) {
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(self.postDetailViewController ?? self.createPostDetailViewController(), animated: true)
    }
}
