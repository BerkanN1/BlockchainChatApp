//
//  ForgetPassword.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 16.01.2024.
//

import SwiftUI

struct ForgetPassword: View {
    
    @State private var username: String = ""
    @State private var pass: String = ""
    @State private var repass: String = ""
    @State private var viewModel = ForgetPasswordViewModel()
    @State private var isPasswordUpdated = false
    @State private var alertManager = AlertManager()

    var body: some View {
        ZStack {
            Color("Color2")
                .ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color("Color1"))
                        
                        TextField("Email Address", text: $username)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack {
                    HStack {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color("Color1"))
                        
                        SecureField("Password", text: $pass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                VStack {
                    HStack {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color("Color1"))
                        
                        SecureField("Password", text: $repass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                HStack(alignment: .top, spacing: 3.0) {
                    Button(action: {
                        // Password Reset İşlemi
                        guard pass == repass else {
                            // Şifreler eşleşmiyorsa alert göster
                            alertManager.showAlert(title: "Error", message: "Passwords do not match.")
                            return
                        }
                        let forgetPasswordModel = ForgetPasswordModel(username: self.username, currentPassword: self.pass, newPassword: self.repass)
                        
                        viewModel.updatePassword(forgetPasswordModel: forgetPasswordModel) { result in
                            switch result {
                            case .success:
                                self.username = ""
                                self.pass = ""
                                self.repass = ""
                                self.isPasswordUpdated = true
                                print("Şifre güncelleme başarılı!")
                            case .failure(let error):
                                // Hata durumu
                                print("Hata oluştu: \(error.localizedDescription)")
                            }
                        }
                    }) {
                        Label("", systemImage: "paperplane.fill")
                            .foregroundColor(.white)
                            .background(Color("Color1"))
                            .font(.title2)
                    }
                    .padding(.all, 8.0)
                    .background(Color("Color1"))
                    .foregroundColor(.white)
                    .cornerRadius(100)
                }
                .padding([.top, .leading])
                
            }
        }
        .navigationTitle("Forget Password")
        .alert(isPresented: $alertManager.showAlert){
            Alert(
                title: Text("Success"),
                message: Text("Password updated successfully."),
                dismissButton: .default(Text("OK")) {
                    // Handle the alert dismissal if needed
                }
            )
        }
    }
}


