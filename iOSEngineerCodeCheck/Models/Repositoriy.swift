//
//  Repositoriy.swift
//  iOSEngineerCodeCheck
//
//  Created by Kai on 2021/04/29.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Repositories: Decodable {
    let items: [Repository]
}

struct Repository: Decodable {
    let fullName: String
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: Owner

    var avatarImageUrl: URL? {
        return URL(string: owner.avatarUrl)
    }
}

struct Owner: Decodable {
    let avatarUrl: String
}
