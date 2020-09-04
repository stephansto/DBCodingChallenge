//
//  PostViewModel.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

struct PostViewModel: Equatable {
    let id: Int
    let title: String
    let body: String
    var favorite: Bool
}
