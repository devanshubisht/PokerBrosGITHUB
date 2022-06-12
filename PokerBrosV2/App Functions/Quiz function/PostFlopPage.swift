//
//  PostFlopPage.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 12/6/22.
//

import UIKit

class PostFlopPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func startGame1() {
        let vc = storyboard?.instantiateViewController(identifier: "PFAquiz") as! PreflopRangeQuizPage
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

