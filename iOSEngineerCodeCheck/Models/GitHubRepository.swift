//
//  GitHubRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by Kai on 2021/04/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

class GitHubRepository {
    
    enum SearchRepositoryError: Error {
        case wrong
        case network
        case parse
    }
    
    static func searchRepository(text: String, completionHandler: @escaping (Result<[Item], SearchRepositoryError>) -> Void) {
        if text.count != 0 {
            
            let urlString = "https://api.github.com/search/repositories?q=\(text)"
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(SearchRepositoryError.wrong))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
                if err != nil {
                    completionHandler(.failure(SearchRepositoryError.network))
                    return
                }
                
                guard let date = data else {return}
                
                if let items = try? jsonStrategyDecoder.decode(Repositories.self, from: date) {
                    completionHandler(.success(items.items))
                } else {
                    print("パースエラー")
                    completionHandler(.failure(SearchRepositoryError.parse))
                }
            }
            task.resume()
        }
    }
    
    static private var jsonStrategyDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
