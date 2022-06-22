//
//  NewExpense.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 22/6/22.
//

import SwiftUI

struct NewExpense: View {
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            // MARK: Close Button
            Button {
                
            } label: {
                Image(systemName: "xmark")
            }
        }
    }
}

struct NewExpense_Previews: PreviewProvider {
    static var previews: some View {
        NewExpense().environmentObject(ExpenseViewModel())
    }
}
