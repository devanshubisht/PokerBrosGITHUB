//
//  AKQuizApp.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 24/7/22.
//

import SwiftUI

@main
struct AKQuizApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView4(gameManagerVM: GameManagerVM())
        }
    }
}
