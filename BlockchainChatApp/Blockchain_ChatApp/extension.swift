//
//  extension.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 17.12.2023.
//

import Foundation
extension SendUserMessage {
    func toUserMessage() -> UserMessage {
        return UserMessage(id: self.id, sender: self.sender, recipient: self.recipient, message: self.message, timestamp: self.timestamp )
    }
}
