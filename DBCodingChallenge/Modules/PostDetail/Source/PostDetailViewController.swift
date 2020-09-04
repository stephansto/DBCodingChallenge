//
//  PostDetailViewController.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol PostDetailView: class {
    func update(with post: PostDetailViewModel, and comments: [CommentViewModel])
}

class PostDetailViewController: UIViewController {
    let postDetailInteractor: PostDetailInteractorProtocol
    var wireframe: WireframeProtocol?
    
    init(postDetailInteractor: PostDetailInteractorProtocol) {
        self.postDetailInteractor = postDetailInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Comments"
        view.backgroundColor = UIColor.Default.secondaryBackground
        
        postDetailInteractor.onViewDidLoad()
    }
}

extension PostDetailViewController: PostDetailView {
    func update(with post: PostDetailViewModel, and comments: [CommentViewModel]) {
        
    }
}
