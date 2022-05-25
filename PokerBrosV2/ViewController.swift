//
//  ViewController.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 24/5/22.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var UserText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var Login: UIButton!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
 
    
    @IBAction func SIGNUP(_ sender: Any) {
        let email = UserText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = PasswordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, err ) in
            
            if err != nil{
                print("LOL")
            }
            else {
            
                let db = Firestore.firestore()
            
                db.collection("users").addDocument(data: ["Username" : email, "Password": password , "UID" : result!.user.uid]) { error in
                    if error != nil {
                        print("yo")
                    }
                }
            
        }
        
    
    }


    }
    
    
}
    

