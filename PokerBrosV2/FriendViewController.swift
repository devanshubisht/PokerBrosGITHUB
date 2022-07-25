//
//  FriendViewController.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 6/7/22.
//

import UIKit

class FriendViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FriendSystem.system.addFriendObserver {
            self.tableView.reloadData()

        // Do any additional setup after loading the view.
        }
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
                return 1
        
    }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return FriendSystem.system.friendList.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                // Create cell
                var cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell
                if cell == nil {
                    tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
                    cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell
                }
                
                // Modify cell
                cell!.button.setTitle("Remove", for: UIControl.State())
                cell!.emailLabel.text = FriendSystem.system.friendList[indexPath.row].email
                
                cell!.setFunction {
                    let id = FriendSystem.system.friendList[indexPath.row].id
                    FriendSystem.system.removeFriend(id!)
                }
                
                // Return cell
                return cell!
            }
}

