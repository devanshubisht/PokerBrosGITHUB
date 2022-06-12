//
//  PreflopRangePage.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 30/5/22.
//

import UIKit

class PreflopRangePage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func startGame1() {
        let vc = storyboard?.instantiateViewController(identifier: "PRquiz") as! PreflopRangeQuizPage
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}
