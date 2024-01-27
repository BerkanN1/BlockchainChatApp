//
//  Home.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 10.12.2023.
//

import SwiftUI

struct Home: View {
    @State var index = 0
    @State var navigationBarBackButtonHidden = true
    
    var body: some View {
        NavigationView{
            GeometryReader {_ in
                
                ScrollView {
                    VStack {
                        //Logo
                        Image("logo")
                            .resizable()
                            .frame(width: 60, height: 60, alignment: .center)
                        //Login/Signup
                        ZStack {
                            //Sign up
                            Signup(index: $index)
                                .zIndex(Double(self.index))
                                
                            //Login View
                            Login(index: $index)
                               
                        }
                        
                        //Divider
                        HStack(spacing: 15) {
                            Rectangle()
                                .fill(Color("Color1"))
                                .frame(height: 1)
                            
                            Rectangle()
                                .fill(Color("Color1"))
                                .frame(height: 1)
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 50)
                        
                        
                    }
                    .padding(.vertical)
                }
                
            }
            .background(Color("Color").edgesIgnoringSafeArea(.all))
            
        }
       
        
    }
    
}
#Preview {
    Home()
}
