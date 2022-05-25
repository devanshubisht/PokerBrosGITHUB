//
//  SignUpPage.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 25/5/22.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpPage: UIViewController {

    @IBOutlet weak var FirstNameText: UITextField!
    
    @IBOutlet weak var LastNameText: UITextField!
    
    @IBOutlet weak var EmailText: UITextField!
    
    @IBOutlet weak var PasswordText: UITextField!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HideError()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func HideError(){
        ErrorLabel.alpha = 0 
    }
    
    func validateFields() -> String?{
        
        // Check that all fields are filled in
        if FirstNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
        
    }

    
    @IBAction func SignUpTapped(_ sender: Any) {
        
        let err = validateFields()
        
        if err != nil {
            
            // There's something wrong with the fields, show error message
            showError(err!)
        }
        else {
            
            let firstName = FirstNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err ) in
                
                if err != nil{
                    self.showError("Error creating user")
                }
                else {
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }

                }
            
            
            
        }
        
    }
    }
    
    func showError(_ message:String) {
        
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    
    
}
