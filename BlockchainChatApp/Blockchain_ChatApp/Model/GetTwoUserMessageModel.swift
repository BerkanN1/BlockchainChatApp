//
//  GetTwoUserMessageModel.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 17.12.2023.
//

import Foundation

// MARK: - GetTwoUserMessageModel
struct GetTwoUserMessageModel: Codable {
    let messages: [UserMessage]
}

// MARK: - Message
struct UserMessage: Codable {
    let id, sender, recipient, message: String
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sender, recipient, message, timestamp
       
    }
}

protocol CommonMessage {
    var id: String { get }
    var sender: String { get }
    var message: String { get }
    var timestamp: Int { get }
}

extension UserMessage: CommonMessage {}
extension SendUserMessage: CommonMessage {}



