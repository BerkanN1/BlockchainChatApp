//
//  Profile.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 10.12.2023.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationView{
        ZStack {
            Color("Color2")
                .ignoresSafeArea()
            
                VStack {
                    NavigationLink(destination: ForgetPassword(), label: {
                        Text("Forget Password")
                            .font(.title)
                            .foregroundColor(.red)
                    })
                    Divider().background(Color.white)
                     
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), label: {
                        Text("Çıkış Yap")
                            .padding()
                            .foregroundColor(.red)
                            .font(.largeTitle)
                        Image(systemName: "escape")
                            .padding()
                            .foregroundColor(.red)
                            .font(.largeTitle)
                    })
                    Divider().background(Color.white)
                    Spacer()
                }
            }
        .navigationTitle("Profile")
        }
    }
}

#Preview {
    Profile()
}
