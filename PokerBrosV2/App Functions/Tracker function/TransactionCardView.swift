//
//  TransactionCardView.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 21/6/22.
//

import SwiftUI

struct TransactionCardView: View {
    var expense: Expense
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            // MARK: First Letter Avatar
            if let first = expense.remark.first {
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.icon)
                    .frame(width: 50, height: 50)
                    .background {
                        Circle()
                            .fill(Color("Color4"))
                    }
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
            }
            
            Text(expense.remark)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .trailing, spacing: 7) {
                // MARK: Displaying Price
                let price = expenseViewModel.convertNumberToPrice(value: expense.type == .income ? expense.amount : -expense.amount)
                Text(price)
                    .font(.callout)
                    .opacity(0.7)
                    .foregroundColor(expense.type == .income ? Color("Green") : Color("Red"))
                Text(expense.date.formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .opacity(0.5)
                    
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.gray).opacity(0.05)
        }
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
