//
//  GetSendMessageModel.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 17.12.2023.
//

import Foundation

struct SendUserMessageModel: Codable {
    let messages: [SendUserMessage]
}

// MARK: - Message
struct SendUserMessage: Codable {
    let id, sender, recipient, message: String
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sender, recipient, message, timestamp
        
    }
}
