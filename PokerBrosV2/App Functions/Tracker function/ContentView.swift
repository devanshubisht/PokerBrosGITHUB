//
//  ContentView.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 21/6/22.
//

import SwiftUI
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage



struct ContentView: View {

    var body: some View {
        
        NavigationView{
            Home()
                .navigationBarHidden(true)
        }
    }

        }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
