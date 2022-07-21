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
    var amount: Int!
    var username: String!
    
    
    init(userEmail: String, userID: String) {
        self.email = userEmail
        self.id = userID
    }
    
}
