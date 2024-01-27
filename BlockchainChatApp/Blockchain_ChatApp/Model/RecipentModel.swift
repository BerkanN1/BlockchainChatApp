//
//  RecipentModel.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 16.01.2024.
//

import Foundation

struct RecipientMessagesResponse: Codable {
    let messages: [RecipientMessage]
}

// MARK: - Message
struct RecipientMessage: Codable {
    let id, sender, recipient, message: String
    let timestamp, v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sender, recipient, message, timestamp
        case v = "__v"
    }
}
