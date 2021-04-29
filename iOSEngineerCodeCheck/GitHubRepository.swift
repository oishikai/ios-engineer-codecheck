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
    
    static func searchRepository(text: String, completionHandler: @escaping (Result<[[String: Any]], SearchRepositoryError>) -> Void) {
        if text.count != 0 {
            
            let urlString = "https://api.gthub.com/search/repositories?q=\(text)"
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(SearchRepositoryError.wrong))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
                if err != nil {
                    completionHandler(.failure(SearchRepositoryError.network))
                    return
                }
                
                guard let Data = data else {return}
                if let obj = try? JSONSerialization.jsonObject(with: Data) as? [String: Any] {
                    if let items = obj["items"] as? [[String: Any]] {
                        completionHandler(.success(items))
                    } else {
                        print("パースエラー")
                        completionHandler(.failure(SearchRepositoryError.parse))
                    }
                } else {
                    print("データ取得エラー")
                    completionHandler(.failure(SearchRepositoryError.parse))
                }
            }
            task.resume()
        }
    }
}
