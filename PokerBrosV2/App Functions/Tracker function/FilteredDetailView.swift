//
//  FilteredDetailView.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 21/6/22.
//

import SwiftUI

struct FilteredDetailView: View {
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    // MARK: Environment Values
    @Environment(\.self) var env
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    // MARK: Back Button
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                    Text("Games")
                        .font(.title.bold())
                        .opacity(0.7)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        expenseViewModel.showFilterView = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }
                
                // MARK: Expense Card View For Currently Selected Date
                ExpenseCard()
                    .environmentObject(expenseViewModel)
                
                CustomSegmentedControl()
                    .padding(.top)
                
                // MARK: Currently Filtered Date with Amount
                VStack(spacing: 15) {
                    Text(expenseViewModel.convertDateToString())
                        .opacity(0.7)
                    
                    Text(expenseViewModel
                        .convertExpenseToCurrency(expenses: expenseViewModel.expenses, type: expenseViewModel.tabName))
                    .font(.title.bold())
                    .opacity(0.9)
                    .animation(.none, value: expenseViewModel.tabName)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
                .padding(.vertical, 20)
                
                ForEach(expenseViewModel.expenses.filter {
                    return $0.type == expenseViewModel.tabName
                }) { expense in
                    TransactionCardView(expense: expense)
                        .environmentObject(expenseViewModel)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .background {
            Color("White")
                .ignoresSafeArea()
        }
        overlay {
            FIlterView()
        }
    }
    
    // MARK: Filter View
    @ViewBuilder
    func FIlterView() -> some View {
        ZStack {
            Color.black
                .opacity(expenseViewModel.showFilterView ? 0.25 : 0)
                .ignoresSafeArea()
            
            if expenseViewModel.showFilterView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Start Date")
                        .font(.caption)
                        .opacity(0.7)
                    
                    DatePicker("", selection: $expenseViewModel.startDate, in: Date.distantPast...Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                    
                    Text("End Date")
                        .font(.caption)
                        .opacity(0.7)
                        .padding(.top, 10)
                    
                    DatePicker("", selection: $expenseViewModel.startDate, in: Date.distantPast...Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                }
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                // MARK: Close Button
                .overlay(alignment: .topTrailing, content: {
                    Button {
                        expenseViewModel.showFilterView = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding(5)
                    }
                })
                .padding()
            }
        }
        .animation(.easeInOut, value: expenseViewModel.showFilterView)
    }
    
    // MARK: Custom Segmented Control
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach([ExpenseType.income, ExpenseType.expense], id: \.rawValue) { tab in
                Text(tab.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(expenseViewModel.tabName == tab ? .white : .black)
                    .opacity(expenseViewModel.tabName == tab ? 1 : 0.7)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background {
                        // MARK: With MatchedGeometry Effect
                        if expenseViewModel.tabName == tab {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                    LinearGradient(colors: [
                                    Color("Color1"),
                                    Color("Color2"),
                                    Color("Color3"),
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {expenseViewModel.tabName = tab}
                    }
            }
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
    }
}

struct FilteredDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredDetailView()
            .environmentObject(ExpenseViewModel())
    }
}
