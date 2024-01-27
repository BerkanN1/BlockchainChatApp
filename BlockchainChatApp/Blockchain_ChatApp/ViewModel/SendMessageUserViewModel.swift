//
//  SendMessageUserViewModel.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 17.12.2023.
//

import SwiftUI
import Combine

class UserSendMessageViewModel: ObservableObject {
    @Published var messages: [SendUserMessage] = []
    @Published var errorMessage: String?

    func fetchMessages(for recipent: String,sender:String) {
        guard let url = URL(string: "http://localhost:3000/chat/\(sender)/\(recipent)") else {
            errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(SendUserMessageModel.self, from: data)
                    self.messages = decodedData.messages
                } catch {
                    self.errorMessage = "Error decoding data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
