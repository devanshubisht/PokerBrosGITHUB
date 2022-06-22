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

class ProfilePage: UIViewController {
    
    
    @IBOutlet weak var ProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveimage()
    }
    
    @IBSegueAction func TrackerSegue(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: Home())
    }
    
    
    func receiveimage () {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let uid1 = Auth.auth().currentUser?.uid
        
        let ref = storageRef.child("profile/"+uid1!)
        
        ProfileImage.sd_setImage(with: ref)

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

