//
//  ContentView.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 21/6/22.
//

import SwiftUI
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage



struct ContentView: View {
    init(){
        self.fetch_stuff()
    }
    var body: some View {
        
        NavigationView{
            Home()
                .navigationBarHidden(true)
        }
    }
    func fetch_stuff() {
        let db = Firestore.firestore()
        let user_id = Auth.auth().currentUser!.uid
        let docRef = db.collection("user").document("\(user_id)")
        
        docRef.getDocument { document, error in
            if error == nil {
                if let document = document {
            let ids = document.data()!["tracker"] as! [Any]
            print(ids)
            for id in ids {
                let TrackerRef = db.collection("tracker").document(id as! String)
                TrackerRef.getDocument { doc, error in
                    if let error = error{
                        return
                    }
                    let trackData = doc?.data()
                    let rem = trackData?["remark"]
                    let amo = trackData?["amount"]
                    let sbb = trackData?["smallBB"]
                    let bb = trackData?["bigBB"]
                    let datedb = trackData?["date"]
                    let typedb = trackData?["type"]
                    let colordb = trackData?["color"]
                    
                    if typedb as! String == "Winnings"{
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        let dateform = dateFormatter.date(from: datedb as! String)
                        
                        
                        let expense = Expense(remark: rem as! String, amount: amo as! Double, smallBlind: sbb as! Double, bigBlind: bb as! Double , date: dateform as! Date, type: .income, color: colordb as! String)
                        withAnimation{sample_expenses.append(expense)}
                    }
                    if typedb as! String == "Losses"{
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        let dateform = dateFormatter.date(from: datedb as! String)

                        
                        let expense = Expense(remark: rem as! String, amount: amo as! Double, smallBlind: sbb as! Double, bigBlind: bb as! Double , date: dateform as! Date, type: .expense, color: colordb as! String)
                        withAnimation{sample_expenses.append(expense)}
                    }
                    
                }
                
            }
        
        }
        }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
