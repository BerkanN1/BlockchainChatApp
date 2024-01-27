//
//  RecipentViewModel.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 16.01.2024.
//


import Foundation
import Combine

class RecipientMessagesViewModel: ObservableObject {
    @Published var messages: [RecipientMessage] = []

    func fetchRecipientMessages(for recipient: String) {
        guard let url = URL(string: "http://localhost:3000/user/messages/\(recipient)") else {
            // Handle invalid URL
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching recipient messages: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data received for recipient messages")
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(RecipientMessagesResponse.self, from: data)
                    self.messages = decodedData.messages
                    print("Recipient Messages: \(self.messages)")
                } catch {
                    print("Error decoding recipient messages: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}



