//
//  JHPCommentClient.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 04.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

class JHPCommentClient: CommentClientProtocol {
    let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
    
    func fetchComments(for postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("posts").appendingPathComponent("\(postId)").appendingPathComponent("comments")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                do {
                    let comments = try JSONDecoder().decode([Comment].self, from: jsonData)
                    completion(.success(comments))
                } catch {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
