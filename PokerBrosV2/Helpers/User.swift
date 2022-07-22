//
//  User.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 6/7/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class User {
    
    var email: String!
    var id: String!
    var amount: Double!
    var username: String!
    
    
    init(userEmail: String, userID: String, useramount: Double, userusername: String) {
        self.email = userEmail
        self.id = userID
        self.amount = useramount
        self.username = userusername
        
    }
    
}
