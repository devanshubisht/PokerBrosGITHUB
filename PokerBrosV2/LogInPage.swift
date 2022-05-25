//
//  LogInPage.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 25/5/22.
//

import UIKit

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
    
}


