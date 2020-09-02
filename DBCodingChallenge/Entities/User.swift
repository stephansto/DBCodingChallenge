//
//  User.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
}
