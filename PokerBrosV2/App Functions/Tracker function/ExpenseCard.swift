//
//  ExpenseCard.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 22/6/22.
//

import SwiftUI

struct ExpenseCard: View {
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    var isFilter: Bool = false
    var body: some View {
        GeometryReader{proxy in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    .linearGradient(colors: [
                        Color("Color5"),
                        //Color("Color6"),
                        //Color("Color7"),
                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            
            VStack(spacing: 15){
                VStack(spacing: 15){
                    // MARK: Currently Going Month Date String
                    Text(isFilter ? expenseViewModel.convertDateToString() : expenseViewModel.currentMonthDateString())
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    // MARK: Current Month Expenses Price
                    Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses))
                        .font(.system(size: 35, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom,5)
                }
                .offset(y: -10)
                
                HStack(spacing: 15){
                    Image(systemName: "arrow.up")
                        .font(.caption.bold())
                        .foregroundColor(Color.icon)
                        .frame(width: 30, height: 30)
                        .background(Color("Color7").opacity(0.7),in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Winnings")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses, type: .income))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Image(systemName: "arrow.down")
                        .font(.caption.bold())
                        .foregroundColor(Color.icon)
                        .frame(width: 30, height: 30)
                        .background(Color("Color7").opacity(0.7),in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Losses")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses, type: .expense))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                }
                .padding(.horizontal)
                .padding(.trailing)
                .offset(y: 15)
            }
            .foregroundColor(Color("Color7"))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 220)
        .padding(.top)
    }
}
