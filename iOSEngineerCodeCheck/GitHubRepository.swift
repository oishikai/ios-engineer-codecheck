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

//                if let obj = try? JSONSerialization.jsonObject(with: date) as? [String: Any] {
//                    if let items = obj["items"] as? [[String: Any]] {
//                        completionHandler(.success(items))
//                    } else {
//                        print("パースエラー")
//                        completionHandler(.failure(SearchRepositoryError.parse))
//                    }
//                } else {
//                    print("データ取得エラー")
//                    completionHandler(.failure(SearchRepositoryError.parse))
//                }
            }
            task.resume()
        }
    }
    
//    static func getImage(repository: [String : Any]) -> URL? {
//        if let owner = repository["owner"] as? [String: Any] {
//            if let avatarURL = owner["avatar_url"] as? String {
//                return URL(string: avatarURL)
////                if let url = url {
////                    return url
////                }
////                Nuke.loadImage(with: url, into: imageView)
//            }
//        }
//        return nil
//    }
    
    static private var jsonStrategyDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
