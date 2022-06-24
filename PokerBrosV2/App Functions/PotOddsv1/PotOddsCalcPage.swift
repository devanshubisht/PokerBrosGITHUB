//
//  PotOddsCalcPage.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 24/6/22.
//

import UIKit

class PotOddsCalcPage: UIViewController {

    @IBOutlet weak var CallAmount: UITextField!
    @IBOutlet weak var PotSizeField: UITextField!
    @IBOutlet weak var CalculateButton: UIButton!
    
    @IBOutlet weak var PotOddsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HideOdds()

        // Do any additional setup after loading the view.
    }
    
    func HideOdds(){
        PotOddsLabel.alpha = 0
    }
    
    @IBAction func CalculateOdds(_ sender: Any) {
        let potodds: Double =  (Double(CallAmount.text!)! / (Double(PotSizeField.text!)! + Double(CallAmount.text!)!) ) * 100
        
        let rounded_potodds = round(potodds)
        
        PotOddsLabel.text = "\(rounded_potodds)%"
        PotOddsLabel.alpha = 1
        
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
