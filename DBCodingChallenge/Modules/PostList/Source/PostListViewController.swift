//
//  PostListViewController.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol PostListView: class {
    func update(postViewModels: [PostViewModel])
}

class PostListViewController: UIViewController {
    let postListInteractor: PostListInteractorProtocol
    let wireframe: WireframeProtocol?
    
    init(postListInteractor: PostListInteractorProtocol, wireframe: WireframeProtocol? = nil) {
        self.postListInteractor = postListInteractor
        self.wireframe = wireframe
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }
}

extension PostListViewController: PostListView {
    func update(postViewModels: [PostViewModel]) {
        
    }
}
