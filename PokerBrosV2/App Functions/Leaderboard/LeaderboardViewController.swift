//
//  LeaderboardViewController.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 21/7/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FriendSystem.system.addFriendObserver{
            self.tableView.reloadData()
        }
        
        
        let id = Auth.auth().currentUser!.uid as String?
        print("initial")
        print(FriendSystem.system.friendList)
        
        Firestore.firestore().collection("users").document(id!).getDocument { document, error in
            if error == nil {
                if let document = document {
                    let email = document.data()?["email"] as! String
                    let id =  document.data()?["uid"] as! String
                    let amount = document.data()?["tot_amount"] as! Double
                    let username = document.data()?["username"] as! String
                    FriendSystem.system.friendList.append(User(userEmail: email, userID: id, useramount: amount, userusername: username))
                    
                    FriendSystem.system.friendList = FriendSystem.system.friendList.sorted(by: { first, second in first.amount < second.amount})
                    
                    print("later")
                    print(FriendSystem.system.friendList)
                    
                    self.tableView.reloadData()
                        
                    }

        // Do any additional setup after loading the view.
                }}}
    
    func numberOfSections(in tableView: UITableView) -> Int {
                return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = FriendSystem.system.friendList[indexPath.row].username
        
        if let amo = FriendSystem.system.friendList[indexPath.row].amount {
            cell.detailTextLabel?.text = "$\(amo)"
        }
        
        
        
        return cell

    }
    

}


