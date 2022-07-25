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
    
    var friend_list = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fecth_user()
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
                    return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return friend_list.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = friend_list[indexPath.row].username
            
            if let amo = friend_list[indexPath.row].amount {
                cell.detailTextLabel?.text = "$\(amo)"
            }
            return cell
        }

        // Do any additional setup after loading the view.
    func fecth_user() {
        let id = Auth.auth().currentUser!.uid as String?
        
        Firestore.firestore().collection("users").document(id!).getDocument{ document, error in
                if error == nil {
                    if let document = document {
                        self.friend_list.removeAll()
                        let friends = document.data()?["friends"] as! [Any]
                        let email = document.data()?["email"] as! String
                        let id =  document.data()?["uid"] as! String
                        let amount = document.data()?["tot_amount"] as! Double
                        let username = document.data()?["username"] as! String
                        let new_user = User(userEmail: email, userID: id, useramount: amount, userusername: username)
                        self.friend_list.append(new_user)
                        print("later")
                        print(self.friend_list)
                        DispatchQueue.main.async {
                                            self.tableView.reloadData()
                                        }
                        
                        for child in friends {
                                    let id_friend = child as! String
                            FriendSystem.system.getUser(id_friend, completion: { (user) in
                                self.friend_list.append(user)
                                print(self.friend_list)

                                DispatchQueue.main.async {
                                    self.friend_list.sort{ $0.amount > $1.amount}
                                                    self.tableView.reloadData()
                                                }
                            })
                        }


                    }}}

    }}


