//
//  UserClientProtocol.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol UserClientProtocol {
    func fetchUserWith(userId: Int, completion: @escaping (Result<User, Error>) -> Void)
}
