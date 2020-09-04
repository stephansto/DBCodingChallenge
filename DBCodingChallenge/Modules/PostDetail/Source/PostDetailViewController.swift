//
//  PostDetailViewController.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

protocol PostDetailView: class {
    func update(with comments: [CommentViewModel])
}

class PostDetailViewController: UIViewController {
    let postDetailInteractor: PostDetailInteractorProtocol
    var wireframe: WireframeProtocol?
    
    var postViewModel: PostViewModel
    var commentViewModels = [CommentViewModel]()
    var favoriteWasChanged = false
    
    let tableView = UITableView()
    
    let postListTableViewCellReuseIdentifier = "postListTableViewCell"
    
    init(postDetailInteractor: PostDetailInteractorProtocol, postViewModel: PostViewModel) {
        self.postDetailInteractor = postDetailInteractor
        self.postViewModel = postViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Comments"
        view.backgroundColor = UIColor.Default.secondaryBackground
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        postDetailInteractor.fetchComments()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent && favoriteWasChanged {
            (wireframe as? PostDetailWireframe)?.delegate?.postIsFavoriteWasChanged(for: postViewModel.id)
        }
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.register(PostListTableViewCell.self, forCellReuseIdentifier: postListTableViewCellReuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pinToSuperView()
    }
}

extension PostDetailViewController: PostDetailView {
    func update(with comments: [CommentViewModel]) {
        
    }
}

extension PostDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: postListTableViewCellReuseIdentifier, for: indexPath) as! PostListTableViewCell
            cell.update(with: postViewModel)
            cell.toggleFavoriteButton.addTarget(self, action: #selector(toggleFavoriteButtonPressed(button:)), for: .touchUpInside)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return commentViewModels.count
        }
    }
    
    @objc func toggleFavoriteButtonPressed(button: UIButton) {
        favoriteWasChanged.toggle()
        postViewModel.favorite.toggle()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
