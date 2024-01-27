//
//  Message.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 10.12.2023.
//

import SwiftUI

struct Message: View {
    @State var isPopoverPresented: Bool = false
    @StateObject var getMessageViewModel = GetMessageViewModel()
    @StateObject var recipientMessagesViewModel = RecipientMessagesViewModel()
    var userEmail: String? {
        UserDefaults.standard.string(forKey: "userEmail")
    }
    
    var body: some View {
        NavigationView{
        ZStack {
            Color("Color2")
                .ignoresSafeArea()
                ScrollView{
                    VStack {
                        let uniqueRecipientsFromGetMessage = Array(Set(getMessageViewModel.messages.map { $0.recipient }))
                        let uniqueRecipientsFromRecipientMessages = Array(Set(recipientMessagesViewModel.messages.map { $0.sender }))
                        let allUniqueRecipients = Array(Set(uniqueRecipientsFromGetMessage + uniqueRecipientsFromRecipientMessages))

                        
                        ForEach(allUniqueRecipients,id: \.self){recipient in
                            if recipient != userEmail {
                                let profileImage = createUserProfileImage(from:recipient)
                                NavigationLink(destination: NewMessage(user: recipient).navigationBarBackButtonHidden(true))
                                {
                                    HStack{
                                        Image(systemName: profileImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            .padding()
                                            .foregroundColor(.white)
                                            .frame(alignment:.leading)
                                        
                                        
                                        Text(recipient)
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
                        .onAppear{
                            print(uniqueRecipientsFromRecipientMessages)
                        }

                    }

                    .onAppear{
                        
                        getMessageViewModel.fetchMessages(for: userEmail ?? "HATA" )
                        recipientMessagesViewModel.fetchRecipientMessages(for: userEmail ?? "")
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: NavigationLink(destination: Chat().navigationBarBackButtonHidden(true), label: {Image(systemName: "person.badge.plus")}))
        }
    }
    func createUserProfileImage(from username: String) -> String {
        let firstLetter = String(username.prefix(1))
        let systemImageName = firstLetter.lowercased() + ".circle.fill"
        return systemImageName
    }
}
#Preview {
    Message()
}
