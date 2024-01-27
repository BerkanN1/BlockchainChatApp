//
//  SendMessageViewModel.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 16.12.2023.
//

import Foundation
import Combine

class SendMessageViewModel: ObservableObject {
    @Published var sendMessageResult: Result<String, Error>? = nil

    func sendMessage(messageModel: SendMessageModel) {
        guard let url = URL(string: "http://localhost:3000/send") else {
            fatalError("Invalid API endpoint URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(messageModel)
        } catch {
            sendMessageResult = .failure(error)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.sendMessageResult = .failure(error)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.sendMessageResult = .failure(NSError(domain: "Invalid data", code: 0, userInfo: nil))
                }
                return
            }

            do {
                let responseMessage = try JSONDecoder().decode(ResponseMessage.self, from: data)
                DispatchQueue.main.async {
                    self.sendMessageResult = .success(responseMessage.message)
                }
            } catch {
                DispatchQueue.main.async {
                    self.sendMessageResult = .failure(error)
                }
            }
        }.resume()
    }
}
