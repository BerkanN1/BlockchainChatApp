//
//  GetMessageModel.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 17.12.2023.
//

import Foundation

// MARK: - GetMessageModel
struct GetMessageModel: Codable {
    let messages: [GetMessage]
}

// MARK: - Message
struct GetMessage: Codable {
    let id, sender, recipient, message: String
    let timestamp, v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sender, recipient, message, timestamp
        case v = "__v"
    }
}
