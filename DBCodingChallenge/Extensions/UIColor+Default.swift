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
        static let primaryBackground = UIColor.systemBlue
        static let secondaryBackground = UIColor.systemTeal
        static let tint = UIColor.systemIndigo
        static let border = UIColor.white
        
        static let primaryText = UIColor.white
        static let secondaryText = Self.primaryText.withAlphaComponent(0.8)
        static let inactive = UIColor.lightGray
    }
}
