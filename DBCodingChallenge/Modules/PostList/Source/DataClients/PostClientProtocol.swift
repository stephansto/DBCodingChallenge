//
//  PostClientProtocol.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol PostClientProtocol {
    func fetchPosts(for user: User, completion: @escaping (Result<[Post], Error>) -> Void)
}
