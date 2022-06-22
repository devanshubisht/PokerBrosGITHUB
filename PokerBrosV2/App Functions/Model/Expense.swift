//
//  NewGame.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 21/6/22.
//

import SwiftUI

//MARK: NewGame Model and Sample Data
struct Expense: Identifiable, Hashable {
    var id = UUID().uuidString
    var remark: String
    var amount: Double
    var date: Date
    var type: ExpenseType
    var color: String
}

enum ExpenseType: String {
    case income = "Winnings"
    case expense = "Losses"
    case all = "ALL"
}

var sample_expenses: [Expense] = [
    Expense(remark: "Yuze House", amount: 1500, date: Date(timeIntervalSince1970: 1652987245), type: .income, color: "Yellow" ),
    Expense(remark: "Yuze House", amount: 700, date: Date(timeIntervalSince1970: 1652987245), type: .expense, color: "Yellow" ),
    Expense(remark: "Justin House", amount: 940, date: Date(timeIntervalSince1970: 1752586245), type: .income, color: "Green" )]
