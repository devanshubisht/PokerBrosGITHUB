//
//  ExpenseViewModel.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 21/6/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage


class ExpenseViewModel: ObservableObject{
    // MARK: Properties
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    
    // MARK: Expense/ Income Tab
    @Published var tabName: ExpenseType = .expense
    // MARK: Filter View
    @Published var showFilterView: Bool = false
    
    // MARK: New Expense Properties
    @Published var addNewExpense: Bool = false
    @Published var amount: String = ""
    @Published var type: ExpenseType = .all
    @Published var date: Date = Date()
    @Published var remark: String = ""
    @Published var smallBlind: String = ""
    @Published var bigBlind: String = ""
    
    init(){
        // MARK: Fetching Current Month Starting Date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month], from: Date())
        
        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
    }
    
    // MARK: This is a Sample Data of Month May
    // You can Customize this Even more with Your Data (Core Data)
    @Published var expenses: [Expense] = sample_expenses
    
    // MARK: Fetching Current Month Date String
    func currentMonthDateString()->String{
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func convertExpensesToCurrency(expenses: [Expense],type: ExpenseType = .all)->String{
        var value: Double = 0
        value = expenses.reduce(0, { partialResult, expense in
            return partialResult + (type == .all ? (expense.type == .income ? expense.amount : -expense.amount) : (expense.type == type ? expense.amount : 0))
        })
        
        return convertNumberToPrice(value: value)
    }
    
    // MARK: Converting Selected Dates To String
    func convertDateToString()->String{
        return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    // MARK: Converting Number To Price
    func convertNumberToPrice(value: Double)->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: .init(value: value)) ?? "$0.00"
    }
    
    // MARK: Converting Number To Decimal
    func convertNumberToDecimal(value: Double)->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: .init(value: value)) ?? "0"
    }
    
    // MARK: Clearing All Data
    func clearData(){
        date = Date()
        type = .all
        remark = ""
        amount = ""
        smallBlind = ""
        bigBlind = ""
    }
    
    // MARK: Save Data
    func saveData(env: EnvironmentValues){
        // MARK: Do Actions Here
        print("Save")
        // MARK: This is For UI Demo
        // Replace With Core Data Actions
        
        let db = Firestore.firestore()
        
        if type == .income {
            
            let amountInDouble = abs((amount as NSString).doubleValue)
            let SBInDouble = abs((smallBlind as NSString).doubleValue)
            let BBInDouble = abs((bigBlind as NSString).doubleValue)
            let colors = ["Yellow","Red","Purple","Green"]
            let expense = Expense(remark: remark, amount: amountInDouble, smallBlind: SBInDouble, bigBlind: BBInDouble, date: date, type: type, color: colors.randomElement() ?? "Yellow")
            withAnimation{expenses.append(expense)}
            withAnimation{sample_expenses.append(expense)}
            
            let ref = db.collection("tracker").document()
            let id = ref.documentID
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let string_date = dateFormatter.string(from: date)
            print(string_date)
            
            ref.setData(
                ["remark" : remark,
                 "amount": abs(amountInDouble),
                 "smallBB":SBInDouble,
                 "bigBB": BBInDouble,
                 "date": string_date,
                 "type": "Winnings",
                 "colour": "Yellow",
                 "id": id
                ])
            let user_id = Auth.auth().currentUser!.uid
            db.collection("users").document("\(user_id)").updateData(["tracker" : FieldValue.arrayUnion([id])])
        }
        else {
            let amountInDouble = (amount as NSString).doubleValue
            let amount_negative = abs(amountInDouble)
            let SBInDouble = abs((smallBlind as NSString).doubleValue)
            let BBInDouble = abs((bigBlind as NSString).doubleValue)
            let colors = ["Yellow","Red","Purple","Green"]
            let expense = Expense(remark: remark, amount: amount_negative, smallBlind: SBInDouble, bigBlind: BBInDouble, date: date, type: type, color: colors.randomElement() ?? "Yellow")
            withAnimation{expenses.append(expense)}
            withAnimation{sample_expenses.append(expense)}
            
            let ref = db.collection("tracker").document()
            let id = ref.documentID
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let string_date = dateFormatter.string(from: date)
            
            ref.setData(
                ["remark" : remark,
                 "amount": amount_negative,
                 "smallBB":SBInDouble,
                 "bigBB": BBInDouble,
                 "date": string_date,
                 "type": "Losses",
                 "colour": "Yellow",
                 "id": id
                ])
            let user_id = Auth.auth().currentUser!.uid
            db.collection("users").document("\(user_id)").updateData(["tracker" : FieldValue.arrayUnion([id])])
            
        }
        
        expenses = expenses.sorted(by: { first, scnd in
            return scnd.date < first.date
        })
        env.dismiss()
    }
}
