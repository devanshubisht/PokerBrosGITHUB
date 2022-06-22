//
//  GameRow.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 14/6/22.
//

//import SwiftUI
//
//struct GameRow: View {
//    var transaction: Transaction
//    
//    var body: some View {
//        HStack(spacing: 20) {
//            // MARK: Transaction Catergory Icon
//            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                .fill(Color.icon.opacity(0.3))
//                .frame(width: 44, height: 44)
//                
//            VStack(alignment: .leading, spacing: 6) {
//                Text(transaction.merchant)
//                    .font(.subheadline)
//                    .bold()
//                    .lineLimit(1)
//                    //.foregroundStyle(Color.text, .primary)
//                
//                // MARK: Transaction Category
//                Text(transaction.category)
//                    .font(.footnote)
//                    .opacity(0.7)
//                    .lineLimit(1)
//                    //.foregroundStyle(Color.text, .primary)
//                
//                // MARK: Transaction Date
//                Text(transaction.dateParsed, format: .dateTime.year().month().day())
//                    .font(.footnote)
//                    //.foregroundStyle(Color.text, .primary)
//            }
//            
//            Spacer()
//            
//            // MARK: Transaction Amount
//            Text(transaction.signedAmount, format: .currency(code: "SGD"))
//                .bold()
//                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
//        }
//        .padding([.top, .bottom], 8)
//    }
//}
//
//
//struct GameRow_Previews: PreviewProvider {
//    static var previews: some View {
//        GameRow(transaction: transactionPreviewData)
//    }
//}
