//
//  NewMessage.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 10.12.2023.

import SwiftUI

struct NewMessage: View {
    
    @State private var messageText = ""
    @State var user: String
    var userId: String? {UserDefaults.standard.string(forKey: "userId")}
    var userEmail: String? {
UserDefaults.standard.string(forKey: "userEmail")}
    @State private var isPopoverPresented: Bool = false
    @ObservedObject var sendMessageViewModel = SendMessageViewModel()
    @StateObject var viewModel = UserMessageViewModel()
    @StateObject var sendviewModel = UserSendMessageViewModel()
    @State private var messageSentSuccessfully = false
    var sortedMessages: [CommonMessage] {
          // Gönderilen ve alınan mesajları birleştirip tarihe göre sırala
          (viewModel.messages as [CommonMessage] + sendviewModel.messages as [CommonMessage])
              .sorted { $0.timestamp < $1.timestamp }
      }
    var body: some View {
        NavigationView{
            ZStack {
                Color("Color2")
                    .ignoresSafeArea()
                VStack {
                    // Gönderilen ve alınan mesajları gösteren bir alan
                    HStack{
                        NavigationLink(destination: Message().navigationBarBackButtonHidden(true), label: {Image(systemName: "lessthan")})
                            .foregroundColor(.pink)
                            .padding()
                        
                        Text(user)
                            .padding()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .font(.title)
                            .bold()
                    }
                    ScrollView{
                        
                        ForEach(sortedMessages, id: \.id) { result in
                                                 if let userMessage = result as? UserMessage {
                                                     // Gönderilen mesaj
                                                     Text( userMessage.message)
                                                         .padding(10)
                                                         .background(Color.pink)
                                                         .foregroundColor(.white)
                                                         .cornerRadius(8)
                                                         .frame(maxWidth: .infinity, alignment: .trailing)
                                                 } else if let sendUserMessage = result as? SendUserMessage {
                                                     // Alınan mesaj
                                                     Text("\(sendUserMessage.sender): \(sendUserMessage.message)")
                                                         .padding(10)
                                                         .background(Color(
                                                             red: Double(117) / 255.0,
                                                             green: Double(4) / 255.0,
                                                             blue: Double(87) / 255.0
                                                         ))
                                                         .foregroundColor(.white)
                                                         .cornerRadius(8)
                                                         .frame(maxWidth: .infinity, alignment: .leading)
                                                 }
                                             }                    }
                    Spacer()
                    HStack{
                        TextField("Enter your message", text: $messageText)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        // Gönder butonu
                        Button {
                            let sendMessageModel = SendMessageModel(userId: userId ?? "deneme", recipient: user, message: messageText)
                            sendMessageViewModel.sendMessage(messageModel: sendMessageModel)
                            messageSentSuccessfully.toggle()
                        } label: {
                            Label("", systemImage: "paperplane.fill")
                                .foregroundColor(.white)
                                .background(Color("Color1"))
                                .font(.title2)
                        }
                        .padding(8)
                        .background(Color("Color1"))
                        .foregroundColor(.white)
                        .cornerRadius(100)
                    }
                    .padding()
                }
                .onAppear{
                    viewModel.fetchMessages(for: user, sender: userEmail ?? "")
                    sendviewModel.fetchMessages(for: userEmail ?? "", sender: user)
                    
                }
                .onReceive([messageSentSuccessfully].publisher.first()) { _ in
                    // This block will be triggered when refreshView changes
                    viewModel.fetchMessages(for: user, sender: userEmail ?? "")
                    sendviewModel.fetchMessages(for: userEmail ?? "", sender: user)
                    if messageSentSuccessfully == true {
                        messageText = ""
                    }
                    
                }
            }
            
        }
    }
}
#Preview {
    NewMessage(user: "Berkan")
}
