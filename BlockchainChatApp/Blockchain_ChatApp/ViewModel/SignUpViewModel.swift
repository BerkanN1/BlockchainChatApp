import Foundation

class SignUpViewModel: ObservableObject {
    @Published var registrationResult: Result<String, Error>? = nil

    func register(user: SignUpModel) {
        guard let url = URL(string: "http://localhost:3000/register") else {
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
                let responseMessage = try JSONDecoder().decode(ResponseMessage.self, from: data)
                DispatchQueue.main.async {
                    self.registrationResult = .success(responseMessage.message)
                }
            } catch {
                DispatchQueue.main.async {
                    self.registrationResult = .failure(error)
                }
            }
        }.resume()
    }
}

struct ResponseMessage: Decodable {
    let message: String
}
