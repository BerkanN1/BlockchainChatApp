import Foundation

class SignInViewModel: ObservableObject {
    @Published var registrationResult: Result<UserData, Error>? = nil

    func register(user: SigninModel) {
        guard let url = URL(string: "http://localhost:3000/login") else {
            fatalError("Invalid API endpoint URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            registrationResult = .failure(error)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.registrationResult = .failure(error)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.registrationResult = .failure(NSError(domain: "Invalid data", code: 0, userInfo: nil))
                }
                return
            }

            do {
                let responseMessage = try JSONDecoder().decode(UserData.self, from: data)
                DispatchQueue.main.async {
                    self.registrationResult = .success(responseMessage)
                }
            } catch {
                DispatchQueue.main.async {
                    self.registrationResult = .failure(error)
                }
            }
        }.resume()
    }
}
struct UserData: Decodable {
    let message: String
    let userId: String
}



