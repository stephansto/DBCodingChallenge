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
    var wireframe: WireframeProtocol?
    
    var showOnlyFavorites = false {
        didSet {
            showAllButton.isSelected.toggle()
            showOnlyFavoritesButton.isSelected.toggle()
        }
    }
    var postViewModels = [PostViewModel]()
    var favoritePostViewModels: [PostViewModel] {
        return self.postViewModels.filter { $0.favorite }
    }
    
    let verticalStackView = UIStackView()
    var tableView = UITableView()
    let horizontalStackView = UIStackView()
    let showAllButton = UIButton()
    let showOnlyFavoritesButton = UIButton()
    
    let postListTableViewCellReuseIdentifier = "postListTableViewCell"
    
    init(postListInteractor: PostListInteractorProtocol) {
        self.postListInteractor = postListInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Posts"
        view.backgroundColor = UIColor.Default.primaryBackground

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.Default.primaryBackground
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = CurrentUser.shared.user {
            postListInteractor.fetchPosts(for: user)
        }
    }
    
    private func setupHierarchy() {
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(tableView)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(showAllButton)
        horizontalStackView.addArrangedSubview(showOnlyFavoritesButton)
    }
    
    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostListTableViewCell.self, forCellReuseIdentifier: postListTableViewCellReuseIdentifier)
        tableView.tableFooterView = UIView()
        
        [showAllButton, showOnlyFavoritesButton].forEach {
            $0.setTitleColor(UIColor.Default.inactive, for: .normal)
            $0.setTitleColor(UIColor.Default.primaryText, for: .selected)
            $0.titleLabel?.font = UIFont.Default.mediumButton
            $0.backgroundColor = UIColor.Default.tint
            $0.addTarget(self, action: #selector(toggleShowOnlyFavoritesButtonPressed(button:)), for: .touchUpInside)
        }
        
        showAllButton.setTitle("ALL", for: .normal)
        showAllButton.isSelected = !showOnlyFavorites

        showOnlyFavoritesButton.setTitle("FAV", for: .normal)
        showOnlyFavoritesButton.isSelected = showOnlyFavorites
    }
    
    private func setupLayout() {
        [verticalStackView, tableView, horizontalStackView, showAllButton, showOnlyFavoritesButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        verticalStackView.axis = .vertical
        verticalStackView.pinToSuperView()
        
        horizontalStackView.distribution = .fillEqually
        
        showAllButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        showOnlyFavoritesButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    @objc func toggleShowOnlyFavoritesButtonPressed(button: UIButton) {
        if !button.isSelected {
            showOnlyFavorites.toggle()
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PostListViewController: PostListView {
    func update(postViewModels: [PostViewModel]) {
        self.postViewModels = postViewModels
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let postViewModel = showOnlyFavorites ? favoritePostViewModels[indexPath.row] : postViewModels[indexPath.row]
        let postDetailWireframe = PostDetailWireframe(postViewModel: postViewModel)
        postDetailWireframe.delegate = self
        postDetailWireframe.start(in: nil, on: navigationController)
    }
}

extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postListTableViewCellReuseIdentifier, for: indexPath) as! PostListTableViewCell
        let postViewModel = showOnlyFavorites ? favoritePostViewModels[indexPath.row] : postViewModels[indexPath.row]
        cell.update(with: postViewModel)
        cell.toggleFavoriteButton.tag = postViewModel.id
        cell.toggleFavoriteButton.addTarget(self, action: #selector(toggleFavoriteButtonPressed(button:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showOnlyFavorites ? favoritePostViewModels.count : postViewModels.count
    }
    
    @objc func toggleFavoriteButtonPressed(button: UIButton) {
        let postId = button.tag
        postListInteractor.toggleFavoriteForPost(with: postId)
    }
}

extension PostListViewController: PostDetailDelegate {
    func postIsFavoriteWasChanged(for postId: Int) {
        postListInteractor.toggleFavoriteForPost(with: postId)
    }
}
