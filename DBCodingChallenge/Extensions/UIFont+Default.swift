//
//  UIFont+Default.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

extension UIFont {
    struct Default {
        static let medium = UIFont.systemFont(ofSize: 20)
        static let small = UIFont.systemFont(ofSize: 14)
        
        static let largeButton = UIFont.systemFont(ofSize: 28)
        static let mediumButton = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        static let primaryCell = UIFont.systemFont(ofSize: 20, weight: .medium)
        static let secondaryCell = UIFont.systemFont(ofSize: 14)
    }
}
