//
//  Main.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 10.12.2023.
//

import SwiftUI

struct Main: View {
    @State private var tabIndex = 0
    var body: some View {
        TabView(selection: $tabIndex) {
            NavigationView {
                Message()
                    .navigationTitle("Messages")
                    
            }
            .tabItem {
                Label("Message", systemImage: "message.fill")
            }
            .tag(0)

            NavigationView {
                Profile()
                    .navigationTitle("Profile")
                    .accentColor(Color("Color1"))
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
            .tag(1)
        }
        .navigationBarBackButtonHidden(true) 
        .accentColor(Color("Color1")) // Tab bar rengi
        
       
    }
    init() {
    UITabBar.appearance().backgroundColor = UIColor.black
    }

}

#Preview {
    Main()
}
