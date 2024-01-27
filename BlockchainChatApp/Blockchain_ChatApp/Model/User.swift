//
//  User.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 16.12.2023.
//

import Foundation

struct UserModel: Codable {
    let users: [User]
}

// MARK: - User
struct User: Codable {
    let id, username, password: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, password
        case v = "__v"
    }
}

