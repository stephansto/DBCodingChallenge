//
//  PostListTableViewCell.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

class PostListTableViewCell: UITableViewCell {
    
    var postViewModel: PostListPostViewModel?
    
    let titleBodyVerticalStackView = UIStackView()
    let buttonVerticalStackView = UIStackView()
    let horizontalStackView = UIStackView()
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    let toggleFavoriteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.orange.withAlphaComponent(0.8)
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        [titleBodyVerticalStackView, buttonVerticalStackView, horizontalStackView, titleLabel, bodyLabel, toggleFavoriteButton].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            
        })
        
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(titleBodyVerticalStackView)
        horizontalStackView.addArrangedSubview(UIView())
        horizontalStackView.addArrangedSubview(buttonVerticalStackView)
        
        titleBodyVerticalStackView.addArrangedSubview(titleLabel)
        titleBodyVerticalStackView.addArrangedSubview(bodyLabel)
        
        buttonVerticalStackView.addArrangedSubview(toggleFavoriteButton)
        buttonVerticalStackView.addArrangedSubview(UIView())
        buttonVerticalStackView.backgroundColor = .yellow
    }
    
    private func setupViews() {
        titleBodyVerticalStackView.axis = .vertical
        titleBodyVerticalStackView.alignment = .leading
        
        buttonVerticalStackView.axis = .vertical
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        titleLabel.numberOfLines = 0
        
        bodyLabel.textColor = .white
        bodyLabel.font = .systemFont(ofSize: 14)
        bodyLabel.numberOfLines = 3
        
        toggleFavoriteButton.setTitle("FAV", for: .normal)
        toggleFavoriteButton.backgroundColor = .brown
    }
    
    private func setupLayout() {
        horizontalStackView.pinToSuperView(constant: 3)
        
        buttonVerticalStackView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        toggleFavoriteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func update(with postViewModel: PostListPostViewModel) {
        titleLabel.text = postViewModel.title
        bodyLabel.text = postViewModel.body
        toggleFavoriteButton.isSelected = postViewModel.favorite
        toggleFavoriteButton.layer.borderWidth = postViewModel.favorite ? 3 : 1
    }
}
