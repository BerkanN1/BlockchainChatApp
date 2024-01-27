//
//  Chat.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 10.12.2023.
//

import SwiftUI

struct Chat: View {
    @StateObject var viewModel = UserViewModel()

    var body: some View {
        NavigationView{
            ZStack {
                Color("Color2")
                    .ignoresSafeArea()
                ScrollView{
                    VStack {
                        
                        ForEach(viewModel.users, id: \.id) { user in
                            let profileImage = createUserProfileImage(from: user.username)
                            
                            NavigationLink(destination: NewMessage(user: user.username)
                                .navigationBarBackButtonHidden(true)

                            )
                            {
                                HStack{
                                    Image(systemName: profileImage)
                                                   .resizable()
                                                   .aspectRatio(contentMode: .fit)
                                                   .frame(width: 50, height: 50)
                                                   .padding()
                                                   .foregroundColor(.white)
                                                   .frame(alignment:.leading)

                                               Text(user.username)
                                        .padding(.bottom)
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                
                            }
                            Divider().background(Color.white)
                        }
                    }
                    .onAppear(perform: {
                        viewModel.fetchUsers()
                    })
                }
            }
            .navigationBarBackButtonHidden(true)
        } 
    }
    func createUserProfileImage(from username: String) -> String {
        // Kullanıcı adından ilk harfi alarak bir String oluştur
        let firstLetter = String(username.prefix(1))
        
        // String'i sistem ikon adı formatına dönüştür
        let systemImageName = firstLetter.lowercased() + ".circle.fill"

        return systemImageName
    }
}

#Preview {
    Chat()
}
