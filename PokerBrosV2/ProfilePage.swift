//
//  ProfilePage.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 29/5/22.
//

import UIKit
import SwiftUI

class ProfilePage: UIViewController {
    
    @IBOutlet var quizButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizButton.setTitle("", for: .normal)
        
        let quizImage = UIImage(named: "Quizzes.png")
        
        quizButton.setImage(quizImage?.withRenderingMode(.alwaysOriginal), for: .normal)
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
