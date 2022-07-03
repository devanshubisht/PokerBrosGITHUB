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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveimage()
        receiveusername()
        TrackertButton.addTarget(self, action: #selector(didtap), for: .touchUpInside)
    }
    
    @objc func didtap(){
        let vc = UIHostingController(rootView: ContentView())
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

