//
//  UIView+Extensions.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

extension UIView {
    enum Edge {
        case top
        case right
        case bottom
        case left
    }
    
    @discardableResult
    func pinToSuperView(edges: [Edge] = [.top, .right, .bottom, .left], constant: CGFloat = 0) -> (topConstraint: NSLayoutConstraint?, rightConstraint: NSLayoutConstraint?, bottomConstraint: NSLayoutConstraint?, leftConstraint: NSLayoutConstraint?) {
        var topConstraint, rightConstraint, bottomConstraint, leftConstraint: NSLayoutConstraint?
        if let superview = self.superview {
            edges.forEach {
            switch $0 {
                case .top:
                    self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
                case .right:
                    self.rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor, constant: -constant).isActive = true
                case .bottom:
                    bottomConstraint = self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
                    bottomConstraint?.isActive = true
                case .left:
                    self.leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor, constant: constant).isActive = true
                }
            }
        }
        return (topConstraint: topConstraint, rightConstraint: rightConstraint, bottomConstraint: bottomConstraint, leftConstraint: leftConstraint)
    }
}
