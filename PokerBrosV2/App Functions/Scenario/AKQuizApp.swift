//
//  AKQuizApp.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 17/7/22.
//

import SwiftUI

@main
struct AKQuizApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView3(gameManagerVM: GameManagerVM())
        }
    }
}

