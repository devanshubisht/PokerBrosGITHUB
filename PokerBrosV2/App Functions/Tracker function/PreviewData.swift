//
//  PreviewData.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 14/6/22.
//

import Foundation
import SwiftUI

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "Fwoc room", account: "Yuze", merchant: "Yuze Hs", amount: 150.5, type: "credit", categoryID: 801, category: "1/1", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
