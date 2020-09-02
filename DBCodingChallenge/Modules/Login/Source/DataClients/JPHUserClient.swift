//
//  JPHUserClient.swift
//  DBCodingChallenge
//
//  Created by Storch, Stephan on 02.09.20.
//  Copyright © 2020 Storch, Stephan. All rights reserved.
//

import Foundation

class JPHUserClient: UserClientProtocol {
    let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
    
    func fetchUserWith(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("users").appendingPathComponent("\(userId)")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                do {
                    let user = try JSONDecoder().decode(User.self, from: jsonData)
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
