//
//  ContentView.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 10.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home().preferredColorScheme(.dark)
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
