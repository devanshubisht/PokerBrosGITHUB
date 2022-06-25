//
//  NewExpense.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 24/6/22.
//

import SwiftUI

struct NewExpense: View {
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    // MARK: Environment Values
    @Environment(\.self) var env
    var body: some View {
        VStack{
            VStack(spacing: 15){
                Text("ADD GAME")
                    .font(.title2)
                    .fontWeight(.bold)
                    .opacity(0.8)
                    .foregroundColor(Color.icon)
                
                // MARK: Custom TextField
                // For Currency Symbol
                if let symbol = expenseViewModel.convertNumberToPrice(value: 0).first{
                    TextField("0", text: $expenseViewModel.amount)
                        .font(.system(size: 35))
                        .foregroundColor(Color("Color2"))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background{
                            Text(expenseViewModel.amount == "" ? "0" : expenseViewModel.amount)
                                .font(.system(size: 35))
                                .opacity(0)
                                .overlay(alignment: .leading) {
                                    Text(String(symbol))
                                        .opacity(0.5)
                                        .offset(x: -15, y: 5)
                                }
                        }
                        .padding(.vertical,10)
                        .frame(maxWidth: .infinity)
                        .background{
                            Capsule()
                                .fill(Color.icon)
                        }
                        .padding(.horizontal,20)
                        .padding(.top)
                }
                
                Label {
                    // MARK: CheckBoxes
                    CustomCheckboxes()
                } icon: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.icon)
                }
                .padding(.top,25)
                
                // MARK: Custom Labels
                HStack {
                    Label {
                        TextField("SB",text: $expenseViewModel.smallBlind)
                            .padding(.leading,10)
                    } icon: {
                        Image(systemName: "list.bullet.rectangle.portrait.fill")
                            .font(.title3)
                            .foregroundColor(Color("Gray"))
                    }
                    .padding(.vertical,20)
                    .padding(.horizontal,15)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.icon)
                    }
                    .padding(.top,5)
                    
                    Label {
                        TextField("BB",text: $expenseViewModel.bigBlind)
                            .padding(.leading,10)
                    } icon: {
                        Image(systemName: "list.bullet.rectangle.portrait.fill")
                            .font(.title3)
                            .foregroundColor(Color("Gray"))
                    }
                    .padding(.vertical,20)
                    .padding(.horizontal,15)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.icon)
                    }
                    .padding(.top,5)
                }
                
                // MARK: Custom Labels
                Label {
                    TextField("Location",text: $expenseViewModel.remark)
                        .padding(.leading,10)
                } icon: {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.icon)
                }
                .padding(.top,5)
                
                
                Label {
                    DatePicker.init("", selection: $expenseViewModel.date,in: Date.distantPast...Date(),displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading,10)
                } icon: {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.icon)
                }
                .padding(.top,5)
            }
            .frame(maxHeight: .infinity,alignment: .center)
            
            // MARK: Save Button
            Button(action: {expenseViewModel.saveData(env: env)}) {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.vertical,15)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                                LinearGradient(colors: [
                                    Color("Color5"),
                                    //Color("Color6"),
                                    //Color("Color7"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    }
                    .foregroundColor(Color("Color7"))
                    .padding(.bottom,10)
            }
            .disabled(expenseViewModel.remark == "" || expenseViewModel.type == .all || expenseViewModel.amount == "")
            .opacity(expenseViewModel.remark == "" || expenseViewModel.type == .all || expenseViewModel.amount == "" ? 0.6 : 1)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Color("BackgroundC")
                .ignoresSafeArea()
        }
        .overlay(alignment: .topTrailing) {
            // MARK: Close Button
            Button {
                env.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.icon)
                    .opacity(1)
            }
            .padding()
        }
    }
    
    // MARK: Checkboxes
    @ViewBuilder
    func CustomCheckboxes()->some View{
        HStack(spacing: 10){
            ForEach([ExpenseType.income,ExpenseType.expense],id: \.self){type in
                ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black,lineWidth: 2)
                        .opacity(0.5)
                        .frame(width: 20, height: 20)
                    
                    if expenseViewModel.type == type{
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(Color("Green"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    expenseViewModel.type = type
                }
                
                Text(type.rawValue.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(0.7)
                    .padding(.trailing,10)
            }
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.leading,10)
    }
}

struct NewExpense_Previews: PreviewProvider {
    static var previews: some View {
        NewExpense()
            .environmentObject(ExpenseViewModel())
    }
}
