//
//  ReusableText.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 24/7/22.
//

import Foundation
import SwiftUI

struct ReusableText: View {
    var text: String
    var size: CGFloat
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .shadow(color: Color("icon"), radius: 2, x: 0, y: 3)
    }
}
