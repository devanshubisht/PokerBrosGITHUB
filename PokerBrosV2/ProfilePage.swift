//
//  ProfilePage.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 29/5/22.
//

import UIKit
import Photos
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI
import MetricKit

class ProfilePage: UIViewController {
    
    @IBOutlet weak var TrackertButton: UIButton!
    
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var Username: UILabel!
    
    @IBOutlet weak var ScenarioButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveimage()
        receiveusername()
        fetch_stuff()
        TrackertButton.addTarget(self, action: #selector(didtap), for: .touchUpInside)
        ScenarioButton.addTarget(self, action: #selector(scentap), for: .touchUpInside)
    }
    
    @objc func didtap(){
        let vc = UIHostingController(rootView: ContentView())
        present(vc, animated: true)
    }
    
    @objc func scentap(){
        let vc = UIHostingController(rootView: ContentView4(gameManagerVM: GameManagerVM()))
        present(vc, animated: true)
    }
    
//    @IBSegueAction func TrackerSegue(_ coder: NSCoder) -> UIViewController? {
//        return  UIHostingController(coder: coder, rootView: ContentView())}
    
    
    func receiveimage () {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let uid1 = Auth.auth().currentUser?.uid
        
        let ref = storageRef.child("profile/"+uid1!)
        
        ProfileImage.sd_setImage(with: ref)

        }
    
    func receiveusername () {
        let db = Firestore.firestore()
        let uid1 = Auth.auth().currentUser?.uid
        let docref = db.collection("users").document(uid1!)
        
        docref.getDocument { (document, error) in
            if let error = error {
                print("Failed to fetch current user")
                return
            }
            guard let data = document?.data() else {return}
            let username = data["username"]
            self.Username.text = username as! String
        } }
        
    
        func fetch_stuff() {
            sample_expenses.removeAll()
            let db = Firestore.firestore()
            let uid1 = Auth.auth().currentUser?.uid
            let docref = db.collection("users").document(uid1!)
            
            docref.getDocument { (document, error) in
                if let error = error {
                    print("Failed to fetch current user")
                    return
                }
                guard let data = document?.data() else {return}
                var curr_amount = Double(0)
                let id = data["tracker"] as? [Any]
                        if (data["tracker"]) != nil {
                            let ids = data["tracker"] as! [Any]
                print(ids)
                for id in ids {
                    let TrackerRef = db.collection("tracker").document(id as! String)
                    TrackerRef.getDocument { doc, error in
                        if let error = error{
                            return
                        }
                        let trackData = doc?.data()
                        let rem = trackData?["remark"]
                        let amo = trackData?["amount"]
                        let sbb = trackData?["smallBB"]
                        let bb = trackData?["bigBB"]
                        let datedb = trackData?["date"]
                        let typedb = trackData?["type"]
                        let colordb = trackData?["colour"]
                        
                        if typedb as! String == "Winnings"{
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            let dateform = dateFormatter.date(from: datedb as! String)
                            let expense = Expense(remark: rem as! String, amount: amo as! Double, smallBlind: sbb as! Double, bigBlind: bb as! Double , date: dateform!, type: .income, color: colordb as! String)
                            
                            let new_amount = (amo as! Double) + (curr_amount as! Double)
                            curr_amount = new_amount as! Double
                            
                            docref.updateData(["tot_amount" : new_amount])
                            
                            print(expense)
                            withAnimation{sample_expenses.append(expense)}
                        }
                            
                        if typedb as! String == "Losses"{
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            let dateform = dateFormatter.date(from: datedb as! String)

                            
                            let expense = Expense(remark: rem as! String, amount: amo as! Double, smallBlind: sbb as! Double, bigBlind: bb as! Double , date: dateform as! Date, type: .expense, color: colordb as! String)
                            
                            let new_amount = (curr_amount as! Double) - (amo as! Double)
                            curr_amount = new_amount as! Double
                            
                            docref.updateData(["tot_amount" : new_amount])
                            
                            withAnimation{sample_expenses.append(expense)
                            
                        }
                    
                }
                            
                        }
            
            }
                            sample_expenses = sample_expenses.sorted(by: { first, scnd in
                                return scnd.date < first.date
                        })
            }
    
    }
        }
}
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

