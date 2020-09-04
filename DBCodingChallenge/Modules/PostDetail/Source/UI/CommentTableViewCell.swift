//
//  CommentTableViewCell.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    let verticalStackView = UIStackView()
    let userLabel = UILabel()
    let bodyLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.Default.secondaryBackground
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        [verticalStackView, userLabel, bodyLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            
        })
        
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(userLabel)
        verticalStackView.addArrangedSubview(bodyLabel)
    }
    
    private func setupViews() {
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        
        userLabel.textColor = UIColor.Default.primaryText
        userLabel.font = UIFont.Default.primaryCell
        userLabel.numberOfLines = 1
        
        bodyLabel.textColor = UIColor.Default.secondaryText
        bodyLabel.font = UIFont.Default.secondaryCell
        bodyLabel.numberOfLines = 0
    }
    
    private func setupLayout() {
        verticalStackView.pinToSuperView(constant: 3)
    }
    
    func update(with commentViewModel: CommentViewModel) {
        userLabel.text = "User: \(commentViewModel.username)"
        bodyLabel.text = commentViewModel.body
        selectionStyle = .none
    }
}
