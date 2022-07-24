//
//  ScenarioViewController.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 24/7/22.
//

import UIKit
import SwiftUI

class ScenarioViewController: UIViewController {

    @IBOutlet weak var ScenarioButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScenarioButton.addTarget(self, action: #selector(scentap), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    @objc func scentap(){
        let vc = UIHostingController(rootView: ContentView4(gameManagerVM: GameManagerVM()))
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
