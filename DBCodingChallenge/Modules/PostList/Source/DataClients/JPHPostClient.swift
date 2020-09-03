//
//  JPHPostClient.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 03.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

class JPHPostClient: PostClientProtocol {
    let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
    
    func fetchPosts(for user: User, completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("users").appendingPathComponent("\(user.id)").appendingPathComponent("posts")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                do {
                    let user = try JSONDecoder().decode([Post].self, from: jsonData)
                    completion(.success(user))
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
