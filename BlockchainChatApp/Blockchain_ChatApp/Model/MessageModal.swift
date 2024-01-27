//
//  Message.swift
//  ChatAppDemo
//
//  Created by BERKAN NALBANT on 10.12.2023.
//
import Foundation

struct MessageModal: Identifiable, Codable {
    var id: String
    var message: String
    var sender:String
    var recipient: String
    var timeStamp: Date
}
