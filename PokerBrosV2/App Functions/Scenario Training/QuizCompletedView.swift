//
//  QuizCompletedView.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 24/7/22.
//

import Foundation
import SwiftUI

struct QuizCompletedView: View {
    var gameManagerVM: GameManagerVM
    var body: some View {
        VStack {
            Image(systemName: "gamecontroller.fill")
                .foregroundColor(Color("Icon"))
                .font(.system(size: 60))
                .padding()
            
            ReusableText(text: gameManagerVM.model.quizWinningStatus ?
                         "THAT'S A WRAP" :
                            "GAME OVER",
                         size: 30)
                .padding()
            
            ReusableText(text: gameManagerVM.model.quizWinningStatus
                         ? "Thank you for playing!!"
                         : "Better luck next time",
                         size: 30)
                .padding()
            
            Button {
                gameManagerVM.restartGame()
            } label: {
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .padding()
                    
                    Text("Play Again")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                }
            }.frame(width: 300, height: 60, alignment: .center)
                .background(Color("Icon").opacity(0.7))
                .cornerRadius(30)
                .padding()
            
        }
        .background(Image("bg2"))
    }
}
