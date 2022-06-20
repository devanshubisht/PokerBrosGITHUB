//
//  Tracker.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 14/6/22.
//

import SwiftUI

struct Tracker: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Mark: Title
                    Text("Overview")
                        .font(.system(.title2, design: .rounded))
                        .bold()
                        .foregroundStyle(Color.text, .primary)
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Mark : Notification Icon
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct Tracker_Previews: PreviewProvider {
    static var previews: some View {
        Tracker()
    }
}
