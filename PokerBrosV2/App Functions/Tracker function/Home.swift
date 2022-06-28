//
//  Home.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 21/6/22.
//

import SwiftUI

struct Home: View {
    @StateObject var expenseViewModel: ExpenseViewModel = .init()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12){
                HStack(spacing: 15){
                    VStack(alignment: .leading, spacing: 4) {
                        Text("TRACKER")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.icon)
                        /**NavigationLink {
                            ProfilePage()
                        } label: {
                            Image(systemName: "arrow.backward.circle.fill")
                                .foregroundColor(.gray)
                                .frame(width: 40, height: 40)
                                .background(Color.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                        }*/
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    NavigationLink {
                        FilteredDetailView()
                            .environmentObject(expenseViewModel)
                    } label: {
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.black)
                            .overlay(content: {
                                Circle()
                                    .stroke(Color.icon,lineWidth: 2)
                                    .padding(7)
                            })
                            .frame(width: 40, height: 40)
                            .background(Color.icon,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }
                ExpenseCard()
                    .environmentObject(expenseViewModel)
                TransactionsView()
            }
            .padding()
        }
        .background{
            Color("backgroundC")
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $expenseViewModel.addNewExpense) {
            expenseViewModel.clearData()
        } content: {
            NewExpense()
                .environmentObject(expenseViewModel)
        }
        .overlay(alignment: .bottomTrailing) {
            AddButton()
        }
    }
    
    // MARK: Add New Expense Button
    @ViewBuilder
    func AddButton()->some View{
        Button {
            expenseViewModel.addNewExpense.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color("Color7"))
                .frame(width: 55, height: 55)
                .background{
                    Circle()
                        .fill(
                            .linearGradient(colors: [
                                Color("Color5"),
                                //Color("Color6"),
                                //Color("Color7"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
        .padding()
    }
    
    // MARK: Transactions View
    @ViewBuilder
    func TransactionsView()->some View{
        VStack(spacing: 15){
            Text("GAMES")
                .font(.title2.bold())
                .opacity(1)
                .frame(maxWidth: .infinity,alignment: .leading)
                .foregroundColor(.icon)
                .padding(.bottom)
            
            ForEach(expenseViewModel.expenses){expense in
                // MARK: Transaction Card View
                TransactionCardView(expense: expense)
                    .environmentObject(expenseViewModel)
            }
        }
        .padding(.top)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


