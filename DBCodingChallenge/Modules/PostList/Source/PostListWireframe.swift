//
//  PostListWireframe.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

class PostListWireframe {
    func start(in window: UIWindow?) {
        guard let window = window else { return }
        
        let postListViewController = PostListViewController()
        let navigationController = UINavigationController(rootViewController: postListViewController)
        window.rootViewController = navigationController
        
//        let postListInteractor = PostListInteractor(postClient: RemotePostClient())
//        
//        let postListViewController = PostListViewController()
//        
//        let postListPresenter = PostListPresenter()
//        postListInteractor.presenter = postListPresenter
//        postListPresenter.postListView = postListViewController
//        postListViewController.interactor = postListInteractor
//        
//        let navigationController = UINavigationController(rootViewController: postListViewController)
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
//        
//        if CurrentUser.shared.user == nil {
//            LoginWireframe().showLogin(from: navigationController, animated: false)
//        }
    }
}
