//
//  Extensions.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 14/6/22.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("BackgroundC")
    static let icon = Color("Icon")
    static let text = Color("Text")
    
}

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        print("Initializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "mm/dd/yyyy"
        
        return formatter
    }()
}

extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        
        return parsedDate
    }
}
