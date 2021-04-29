//
//  Repositoriy.swift
//  iOSEngineerCodeCheck
//
//  Created by Kai on 2021/04/29.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Items: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let fullName: String
    let language: String?
    let owner: Owner
}

struct Owner: Decodable {
    let avatarUrl: String
}
