//
//  CurrentUser.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

// For simplity to save and share the user after login
class CurrentUser {
    static let shared = CurrentUser()
    
    var user: User?
}
