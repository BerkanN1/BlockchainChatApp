//
//  ForgetPasswordViewModel.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 16.01.2024.
//

import Foundation

class ForgetPasswordViewModel {
    
    func updatePassword(forgetPasswordModel: ForgetPasswordModel, completion: @escaping (Result<Void, Error>) -> Void) {
        // HTTP Post request logic
        let url = URL(string: "http://localhost:3000/update-password")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(forgetPasswordModel)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // Handle the response as needed
                // Assuming the response is of type Void for simplicity
                completion(.success(()))
            }
            
            task.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
}
