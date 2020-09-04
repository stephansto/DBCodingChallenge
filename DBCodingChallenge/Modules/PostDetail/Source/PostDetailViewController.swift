//
//  PostDetailViewController.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol PostDetailView: class {}

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
}

extension PostDetailViewController: PostDetailView {}
