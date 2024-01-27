//
//  Signup.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 10.12.2023.
//

import SwiftUI

struct Signup: View {
    @State private var email = ""
    @State private var pass = ""
    @State private var repass = ""
    @Binding var index: Int
    @StateObject private var registrationViewModel = SignUpViewModel()
    @State private var registrationSuccess = false // New state to control navigation
    @StateObject private var alertManager = AlertManager()

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Spacer(minLength: 0)
                    VStack(spacing: 10) {
                        Text("Signup")
                            .foregroundColor(self.index == 1 ? .white : .gray)
                            .font(.title2)
                            .fontWeight(.bold)

                        Capsule()
                            .fill(self.index == 1 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                }
                .padding(.top, 30)

                VStack {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color("Color1"))

                        TextField("Email Address", text: self.$email)
                    }

                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)

                VStack {
                    HStack {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color("Color1"))

                        SecureField("Password", text: self.$pass)
                    }

                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)

                VStack {
                    HStack {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color("Color1"))

                        SecureField("Password", text: self.$repass)
                    }

                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }
            .padding()
            .padding(.bottom, 65)
            .background(Color("Color2"))
            .clipShape(CShapeLeft())
            .contentShape(CShapeLeft())
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
                self.index = 1
            }
            .cornerRadius(35)
            .padding(.horizontal, 20)

            Button(action: {
                
                if pass==repass{
                    let user = SignUpModel(username: email, password: pass)
                    registrationViewModel.register(user: user)
                }else{
                    alertManager.showAlert(title: "Error", message: "Şifreler aynı değil.")
                }
            }) {
                Text("Sign up")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color("Color1"))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }
            .offset(y: 25)
            .opacity(self.index == 1 ? 1 : 0)
        }
        .onReceive(registrationViewModel.$registrationResult) { result in
            switch result {
            case .success(let message):
                print("Registration successful: \(message)")
                // Navigate to the main screen or perform other actions on success
                registrationSuccess = true
            case .failure(let error):
                print("Registration failed: \(error.localizedDescription)")
                // Handle failure, display an error message, etc.
            case .none:
                print("ok1")
            }
        }
        
        .background(
            NavigationLink(
                destination: ContentView(),
                isActive: $registrationSuccess,
                label: { EmptyView() }
            )
            .hidden()
        )
        .alert(isPresented: $alertManager.showAlert){
            Alert(
                title: Text(alertManager.alertTitle),
                message: Text(alertManager.alertMessage),
                dismissButton: .default(Text("OK")) {
                    alertManager.hideAlert()
                }
            )
        }
    }
}
