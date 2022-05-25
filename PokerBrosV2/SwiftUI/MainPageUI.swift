//
//  MainPageUI.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 25/5/22.
//

import SwiftUI

struct Home: View {
    
    @State var showSignUp = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
            ZStack{
                
                // Transitions...
                if showSignUp {
                    SignUp()
                        .transition(.move(edge: .trailing))
                } else {
                    Login()
                        .transition(.move(edge: .trailing))
                    
                }
            }
            .overlay(
        
            HStack{
                
                Text(showSignUp ? "Already Member?" : "New Member?")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Button(action: {
                    withAnimation{
                        showSignUp.toggle()
                    }
                }, label: {
                    Text(showSignUp ? "sign in" : "sign up")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                })
            }
            
            ,alignment:.bottom
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

