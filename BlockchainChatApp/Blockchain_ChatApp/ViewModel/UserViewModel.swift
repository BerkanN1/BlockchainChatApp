//
//  UserViewModel.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 16.12.2023.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published var users: [User] = []

    func fetchUsers() {
        guard let url = URL(string: "http://localhost:3000/user") else {
            // Geçersiz URL'yi işleyin
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // Hata ile başa çıkın
                print("Hata: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("HTTP İsteği Başarısız")
                return
            }

            if let data = data {
                do {
                    print("Alınan veri: \(String(data: data, encoding: .utf8) ?? "Veri yok")")

                    let userModel = try JSONDecoder().decode(UserModel.self, from: data)
                    DispatchQueue.main.async {
                        self.users = userModel.users
                    }
                } catch {
                    // Çözme hatası ile başa çıkın
                    print("Çözme Hatası: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
