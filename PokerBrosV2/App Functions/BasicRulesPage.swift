//
//  BasicRulesPage.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 30/5/22.
//

import UIKit

class BasicRulesPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startGame() {
        let vc = storyboard?.instantiateViewController(identifier: "BRquiz") as! BasicRulesQuizPage
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
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
