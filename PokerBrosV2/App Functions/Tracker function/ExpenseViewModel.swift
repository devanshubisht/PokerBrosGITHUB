//
//  ExpenseViewModel.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 21/6/22.
//

import SwiftUI

class ExpenseViewModel: ObservableObject {
    // MARK: Properties
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    
    // MARK: Win / Loss Tab
    @Published var tabName: ExpenseType = .expense
    
    // MARK: Filter View
    @Published var showFilterView: Bool = false
    
    
    init() {
        // MARK: Fetching Current Month Starting Date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        
        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
        
    }
    
    // MARK: This is a Sample Date of Month June
    // You can Customize this Even more with Your Data (Core Data)
    @Published var expenses: [Expense] = sample_expenses
    
    // MARK: Fetching Current Month Date String
    func currentMonthDateString() -> String {
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func convertExpenseToCurrency(expenses: [Expense], type: ExpenseType = .all) -> String {
        var value: Double = 0
        value = expenses.reduce(0, { partialResult, expense in partialResult + (type == .all ? (expense.type == .income ? expense.amount : -expense.amount) : (expense.type == type ? expense.amount : 0))
        })
        
        return convertNumberToPrice(value: value)
        
    }
    
    // MARK: Converting Selected Dates To String
    func convertDateToString() -> String {
        return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    // MARK: Converting Number to Price
    func convertNumberToPrice(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: .init(value: value)) ?? "$0.00"
    }
}

