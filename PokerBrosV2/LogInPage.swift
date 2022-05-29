//
//  LogInPage.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 25/5/22.
//

import UIKit
import FirebaseAuth

class LogInPage: UIViewController {

    @IBOutlet weak var UsernameText: UITextField!
    
    @IBOutlet weak var PasswordText: UITextField!
    
    @IBOutlet weak var LogInButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        HideError()
    }
    
    func HideError(){
        ErrorLabel.alpha = 0
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Validate Text Fields
    func validateFields() -> String?{
        
        // Check that all fields are filled in
        if  UsernameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
        
    }
    
    func showError(_ message:String) {
        
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }

    @IBAction func loginTapped(_ sender: Any) {
    
        
        let error = validateFields()
        
        if error != nil {
            // There's something wrong with the fields, show error message
            showError(error!)
        } else {
            // Create cleaned versions of the text field
            let email = UsernameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Signing in user
            Auth.auth().signIn(withEmail: email, password: password) {
                (result, error) in
                
                if error != nil {
                    // Couldn't sign in
                    self.ErrorLabel.text = error!.localizedDescription
                    self.ErrorLabel.alpha = 1
                } else {
                    
                    let homeViewController =
                    self.storyboard?.instantiateViewController(identifier:
                    Constants.Storyboard.homeViewController) as?
                    HomePage
                    
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
                    
                }
            }
        }
    }
}


