//
//  GitHubRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by Kai on 2021/04/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import Reachability

class GitHubRepository {
    
    private static var task: URLSessionTask?
    
    enum SearchRepositoryError: Error {
        case wrong
        case network
        case parse
    }
    
    static func searchRepository(text: String, completionHandler: @escaping (Result<[Repository], SearchRepositoryError>) -> Void) {
        if !text.isEmpty {
            
            let reachability = try! Reachability()
            if reachability.connection == .unavailable {
                completionHandler(.failure(SearchRepositoryError.network))
                return
            }
            
            let urlString = "https://api.github.com/search/repositories?q=\(text)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
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
                
                if let result = try? jsonStrategyDecoder.decode(Repositories.self, from: date) {
                    completionHandler(.success(result.items))
                } else {
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
    
    static func taskCancel() {
        task?.cancel()
    }
}
