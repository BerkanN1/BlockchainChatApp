//
//  Login.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 10.12.2023.
//

import SwiftUI

struct Login: View {
    @State var email = ""
    @State var pass = ""
    @Binding var index: Int
    @State private var isLogged = false
    @StateObject private var registrationViewModel = SignInViewModel()
    @State private var registrationSuccess = false // New state to control navigation
    @StateObject private var alertManager = AlertManager()
   
    var body: some View {
       
            ZStack(alignment: .bottom) {
                VStack {
                    HStack {
                        VStack(spacing: 10) {
                            Text("Login")
                                .foregroundColor(self.index == 0 ? .white : .gray)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Capsule()
                                .fill(self.index == 0 ? Color.blue : Color.clear)
                                .frame(width: 100, height: 5)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.top, 30)
                    
                    //Email Field
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
                    
                    //Password Field
                    VStack {
                        HStack {
                            Image(systemName: "eye.slash.fill")
                                .foregroundColor(Color("Color1"))
                            
                            SecureField ("Password", text: self.$pass)
                        }
                        
                        Divider().background(Color.white.opacity(0.5))
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                    
                    //Forget Password
                    HStack {

                        NavigationLink(destination: ForgetPassword(), label: {
                            Text("Forget your Password ?")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        })
                         
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                }
                .padding()
                .padding(.bottom, 65)
                .background(Color("Color2"))
                .clipShape(CShapeRight())
                .contentShape(CShapeRight())
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                .onTapGesture {
                    self.index = 0
                }
                .cornerRadius(35)
                .padding(.horizontal, 20)

                //Login Butto
                Button(action: {
                    let user = SigninModel(username: email, password: pass)
                    registrationViewModel.register(user: user)
                    
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        .background(Color("Color1"))
                        .clipShape(Capsule())
                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                }
                .offset(y: 25)
                .opacity(self.index == 0 ? 1 : 0)
                

            }
            .onReceive(registrationViewModel.$registrationResult) { result in
                switch result {
                case .success(let userData):
                    print("Registration successful. Message: \(userData.message), UserID: \(userData.userId)")
                    UserDefaults.standard.set(userData.userId, forKey: "userId")
                    UserDefaults.standard.set(email, forKey: "userEmail")
                    // Navigate to the main screen or perform other actions on success
                    registrationSuccess = true
                case .failure(let error):
                    print("Registration failed: \(error.localizedDescription)")
                    alertManager.showAlert(title: "Error", message: "Login failed. Please check your credentials.")
                case .none:
                    print("ok")
                }
            }
            .background(
                NavigationLink(
                    destination: Main(),
                    isActive: $registrationSuccess,
                    label: { EmptyView() }
                )
                .hidden()
            )
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $alertManager.showAlert){
                Alert(
                    title: Text(alertManager.alertTitle),
                    message: Text(alertManager.alertMessage),
                    dismissButton: .default(Text(alertManager.primaryButtonTitle)) {
                        alertManager.hideAlert()
                    }
                )
            }

    }
     
    
}


