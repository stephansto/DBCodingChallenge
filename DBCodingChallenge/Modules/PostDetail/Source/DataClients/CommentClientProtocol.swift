//
//  CommentClientProtocol.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

protocol CommentClientProtocol {
    func fetchComments(for postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void)
}
