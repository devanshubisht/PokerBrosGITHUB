//
//  Login.swift
//  PokerBros
//
//  Created by Ang Yuze on 24/5/22.
//

import SwiftUI

struct Login: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack{
            
            Text("Sign In")
                .font(.title)
                .fontWeight(.bold)
                // Letter spacing...
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Email and Password...
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Email")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("ilovepoker369@gmail.com", text: $email)
                // Increasing font size and changing text color...
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top,5)
                
                Divider()
            })
            .padding(.top,25)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("philhelmuththepussy", text: $password)
                // Increasing font size and changing text color...
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top,5)
                
                Divider()
            })
            .padding(.top,20)
            
            // Forget password...
            Button(action: {}, label: {
                Text("Forgot password?")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            })
            // This line will reduce the use of unwanted hstack anf spacers...
            .frame(maxWidth: .infinity, alignment:  .trailing)
            .padding(.top,10)
            
            //Next button...
            Button(action: {}, label: {
                Image(systemName: "arrow.right")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.yellow)
                    .padding()
                    .background(.black)
                    .clipShape(Circle())
                // Shadow
                    .shadow(color: Color(.brown).opacity(1), radius: 5, x: 0, y: 0)
            })
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding(.top,10)
        }
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
