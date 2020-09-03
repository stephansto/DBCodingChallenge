//
//  PostListWireframe.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol PostListWireframeProtocol: WireframeProtocol {}

class PostListWireframe: PostListWireframeProtocol {
    var postListViewController: PostListViewController?
    
    private func createPostListViewController() -> PostListViewController {
        let postListPresenter = PostListPresenter()
        let postListInteractor = PostListInteractor(postListPresenter: postListPresenter)
        let postListViewController = PostListViewController(postListInteractor: postListInteractor)
        postListPresenter.postListView = postListViewController
        
        return postListViewController
    }
    
    func start(in window: UIWindow?, on navigationController: UINavigationController?) {
        guard let window = window else { return }
        let postListViewController = self.postListViewController ?? self.createPostListViewController()
        let navigationController = UINavigationController(rootViewController: postListViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
