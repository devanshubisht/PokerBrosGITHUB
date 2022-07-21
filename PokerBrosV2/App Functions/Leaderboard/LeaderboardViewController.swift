//
//  LeaderboardViewController.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 21/7/22.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = FriendSystem.system.friendList[indexPath.row].email
        
        cell.detailTextLabel?.text = "amount"
        
        
        return cell

    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FriendSystem.system.addFriendObserver{
            self.tableView.reloadData()
        }

        // Do any additional setup after loading the view.
    }
    

}


