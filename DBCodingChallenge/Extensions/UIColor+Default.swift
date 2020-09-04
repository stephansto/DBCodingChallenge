//
//  UIColor+Default.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import UIKit

extension UIColor {
    struct Default {
        static let primaryBackground = UIColor(red: 30, green: 49, blue: 113, alpha: 1)
        static let secondaryBackground = UIColor(red: 37, green: 92, blue: 143, alpha: 1)
        static let tint = UIColor(red: 19, green: 30, blue: 55, alpha: 1)
        static let border = UIColor.white
        
        static let primaryText = UIColor.white
        static let secondaryText = Self.primaryText.withAlphaComponent(0.8)
        static let inactive = UIColor.lightGray
    }
}
