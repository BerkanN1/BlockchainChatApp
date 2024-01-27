//
//  SendMessageModel.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 16.12.2023.
//

import Foundation

struct SendMessageModel : Encodable{
    let userId: String
    let recipient: String
    let message: String
    
}
