//
//  FriendSystem.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 4/7/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class FriendSystem {
    
    static let system = FriendSystem()
    
    // MARK: - Firebase references
    /** The base Firebase reference */
    let BASE_REF = Firestore.firestore()    /* The user Firebase reference */
    let USER_REF = Firestore.firestore().collection("users")
    
    /** The Firebase reference to the current user tree */
    var CURRENT_USER_REF: DocumentReference {
        let id = Auth.auth().currentUser!.uid
        return USER_REF.document("\(id)")
    }
    
    /** The Firebase reference to the current user's friend tree
    var CURRENT_USER_FRIENDS_REF: CollectionReference {
        return CURRENT_USER_REF.collection("friends")
    }
    
    /** The Firebase reference to the current user's friend request tree */
    var CURRENT_USER_REQUESTS_REF: CollectionReference {
        return CURRENT_USER_REF.collection("requests")
    }
*/
    /** The current user's id */
    var CURRENT_USER_ID: String {
        let id = Auth.auth().currentUser!.uid
        return id
    }
    
    func getUser(_ userID: String, completion: @escaping (User) -> Void) {
        USER_REF.document(userID).getDocument { document, error in
            if error == nil {
                if let document = document {
                    let email = document.data()?["email"] as! String
                    let id =  document.data()?["uid"] as! String
                    let amount = document.data()?["tot_amount"] as! Double
                    let username = document.data()?["username"] as! String
            completion(User(userEmail: email, userID: id, useramount: amount, userusername: username))
        }
            }
        }
    }

    /** Gets the current User object for the specified user id */
    func getCurrentUser(_ completion: @escaping (User) -> Void) {
        CURRENT_USER_REF.getDocument { document, error in
            if error == nil{
                if let document = document {
                    let email = document.data()?["email"] as! String
                    let id =  document.data()?["uid"] as! String
                    let amount = document.data()?["tot_amount"] as! Double
                    let username = document.data()?["username"] as! String
            completion(User(userEmail: email, userID: id, useramount: amount, userusername: username))
        }
            }
        }
    }

    /** Gets the User object for the specified user id
    func getUser(_ userID: String, completion: @escaping (User) -> Void) {
        USER_REF.child(userID).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            let email = snapshot.childSnapshot(forPath: "email").value as! String
            let id = snapshot.key
            completion(User(userEmail: email, userID: id))
        })
    }
     */

    
    
    // MARK: - Request System Functions
    
    /** Sends a friend request to the user with the specified id */
    func sendRequestToUser(_ userID: String) {
        let db = USER_REF.document(userID)
        db.updateData(["requests" : FieldValue.arrayUnion([CURRENT_USER_ID])])
    }
    
    /** Unfriends the user with the specified id */
    func removeFriend(_ userID: String) {
        CURRENT_USER_REF.updateData(["friends" : FieldValue.arrayRemove([userID])])

        USER_REF.document(userID).updateData(["friends" : FieldValue.arrayRemove([CURRENT_USER_ID])])
    }
    
    /** Accepts a friend request from the user with the specified id */
    func acceptFriendRequest(_ userID: String) {
        CURRENT_USER_REF.updateData(["requests" : FieldValue.arrayRemove([userID])])
        CURRENT_USER_REF.updateData(["friends" : FieldValue.arrayUnion([userID])])
        USER_REF.document(userID).updateData(["requests" : FieldValue.arrayRemove([CURRENT_USER_ID])])
        USER_REF.document(userID).updateData(["friends" : FieldValue.arrayUnion([CURRENT_USER_ID])])
    }
    
    
    
    // MARK: - All users
    /** The list of all users */
    var userList = [User]()
    /** Adds a user observer. The completion function will run every time this list changes, allowing you
     to update your UI. */
    func addUserObserver(_ update: @escaping () -> Void) {
        USER_REF.addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    self.userList.removeAll()
                    for child in snapshot.documents {
                        let user_id = Auth.auth().currentUser!.uid as! String
                        let users_friends = child.data()["friends"] as! [String]
                        print(users_friends)
                        if child.data()["email"] != nil && child.data()["tot_amount"] != nil && users_friends.contains(user_id) == false {
                        let email = child.data()["email"] as! String
                        if email != Auth.auth().currentUser?.email! {
                            self.userList.append(User(userEmail: email, userID: child.data()["uid"] as! String, useramount: child.data()["tot_amount"] as! Double, userusername: child.data()["username"] as! String))
                        }
                        }
                    }
                    update()
                }
            }
        }
    }
        
/*
        USER_REF.getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    self.userList.removeAll()
                    for child in snapshot.documents {
                        let email = child.data()["email"] as! String
                        if email != Auth.auth().currentUser?.email! {
                            self.userList.append(User(userEmail: email, userID: child.data()["uid"] as! String))
                        }
                    }
                    update()
                }
            }
        }
    }
    /** Removes the user observer. This should be done when leaving the view that uses the observer. */
 */

    
    
    
    // MARK: - All friends
    /** The list of all friends of the current user. */
    var friendList = [User]()
    /** Adds a friend observer. The completion function will run every time this list changes, allowing you
     to update your UI. */
    func addFriendObserver(_ update: @escaping () -> Void) {
        CURRENT_USER_REF.addSnapshotListener { document, error in
            if error == nil {
                if let document = document {
                    self.friendList.removeAll()
                    let friends = document.data()?["friends"] as! [Any]
                    for child in friends {
                                let id = child as! String
                        self.getUser(id, completion: { (user) in
                            self.friendList.append(user)
                            update()
                        })
                    }
                    if friends.isEmpty {
                        update()
                    }
                }}}}
    /** Removes the friend observer. This should be done when leaving the view that uses the observer. */
    
    // MARK: - All requests
    /** The list of all friend requests the current user has. */
    var requestList = [User]()
    /** Adds a friend request observer. The completion function will run every time this list changes, allowing you
     to update your UI. */
    func addRequestObserver(_ update: @escaping () -> Void) {
        CURRENT_USER_REF.addSnapshotListener { document, error in
            if error == nil {
                if let document = document {
                    self.requestList.removeAll()
                    let requests = document.data()?["requests"] as! [Any]
                    for child in requests {
                                let id = child as! String
                        self.getUser(id, completion: { (user) in
                            self.requestList.append(user)
                            update()
                        })
                    }
                    if requests.isEmpty {
                        update()
                    }
                }}}}
    
}
