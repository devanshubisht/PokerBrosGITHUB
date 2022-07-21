//
//  GameManagerVM.swift
//  AKQuiz
//
//  Created by richa.e.srivastava on 16/11/2021.
//

import Foundation
import SwiftUI

class GameManagerVM : ObservableObject {

    static var currentIndex = 0
    
    static func createGameModel(i:Int) -> Quiz1 {
        return Quiz1(currentQuestionIndex: i, quizModel: quizData[i])
    }
    
    @Published var model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
    
    
    var timer = Timer()
    var maxProgress = 3000000
    @Published var progress = 0
    
    init() {
        self.start()
    }
    
    func verifyAnswer(selectedOption: QuizOption) {
        for index in model.quizModel.optionsList.indices {
            model.quizModel.optionsList[index].isMatched = false
            model.quizModel.optionsList[index].isSelected = false
            
        }
        if let index = model.quizModel.optionsList.firstIndex(where: {$0.optionId == selectedOption.optionId}) {
            if selectedOption.optionId ==  model.quizModel.answer {
                model.quizModel.optionsList[index].isMatched = true
                model.quizModel.optionsList[index].isSelected = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (GameManagerVM.currentIndex < 4) {
                        GameManagerVM.currentIndex = GameManagerVM.currentIndex + 1
                        self.model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
                    } else {
                        self.model.quizCompleted = true
                        self.model.quizWinningStatus = true
                        self.reset()
                    }
                }
            } else {
                model.quizModel.optionsList[index].isMatched = false
                model.quizModel.optionsList[index].isSelected = true
            }

        }
    }
    
    func restartGame() {
        GameManagerVM.currentIndex = 0
        model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
        self.start()
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats:true, block: { time in
            if self.progress == self.maxProgress {
                self.model.quizCompleted = true
                self.model.quizWinningStatus = false
                self.reset()
            } else {
                self.progress += 1
            }
        })
    }
                                     
    func reset () {
        timer.invalidate()
        self.progress = 0
    }
    
                                     
                                     
                                     
                                

}

extension GameManagerVM
{
    static var quizData: [QuizModel] {
        [
            QuizModel(question: "This is the preflop. You are the Big Blind. Opponent is a very tight preflop player. He raises 4x BB. Make your move",
                      answer: "C",
                      optionsList: [QuizOption(id: 11,optionId: "A", option: "Fold", color: Color.yellow),
                                    QuizOption(id: 12,optionId: "B", option: "Check", color: Color.red),
                                    QuizOption(id: 13,optionId: "C", option: "Call", color: Color.green),
                                    QuizOption(id: 14,optionId: "D", option: "Raise", color: Color.purple)],
                      yourfirst: "as",
                      yoursecond: "ah",
                      flop1: "cardback2",
                      flop2: "cardback2",
                      flop3: "cardback2",
                      turn: "cardback2",
                      river: "cardback2",
                     oppfirst: "cardback2",
                     oppsecond: "cardback2"),
            
            QuizModel(question: "Opponent now checks. What are you gonna do?",
                      answer: "D",
                      optionsList: [QuizOption(id: 21,optionId: "A", option: "Fold", color: Color.yellow),
                                    QuizOption(id: 22,optionId: "D", option: "Check", color: Color.red),
                                    QuizOption(id: 23,optionId: "C", option: "Call", color: Color.green),
                                    QuizOption(id: 24,optionId: "D", option: "Raise", color: Color.purple)],
                      yourfirst: "as",
                      yoursecond: "ah",
                      flop1: "4h",
                      flop2: "7c",
                      flop3: "9s",
                      turn: "cardback2",
                      river: "cardback2",
                     oppfirst: "cardback2",
                     oppsecond: "cardback2"),
            
            QuizModel(question: "You turn the world. Together with a middle pair, you have draws to the straight, as well as to the flush! Opponent checks again. How are you going to exploit this monster draw?",
                      answer: "B",
                      optionsList: [QuizOption(id: 31,optionId: "A", option: "Fold", color: Color.yellow),
                                    QuizOption(id: 32,optionId: "B", option: "Check", color: Color.red),
                                    QuizOption(id: 33,optionId: "C", option: "Call", color: Color.green),
                                    QuizOption(id: 34,optionId: "B", option: "Raise", color: Color.purple)],
                      yourfirst: "as",
                      yoursecond: "ah",
                      flop1: "4h",
                      flop2: "7c",
                      flop3: "9s",
                      turn: "6h",
                      river: "cardback2",
                     oppfirst: "cardback2",
                     oppsecond: "cardback2"),
            
            QuizModel(question: "The Queen of Diamonds bricks all your draws. Your hand has now become dog shit",
                      answer: "B",
                      optionsList: [QuizOption(id: 41,optionId: "A", option: "Fold", color: Color.yellow),
                                    QuizOption(id: 42,optionId: "B", option: "Check", color: Color.red),
                                    QuizOption(id: 43,optionId: "C", option: "Call", color: Color.green),
                                    QuizOption(id: 44,optionId: "D", option: "Raise", color: Color.purple)],
                      yourfirst: "as",
                      yoursecond: "ah",
                      flop1: "4h",
                      flop2: "7c",
                      flop3: "9s",
                      turn: "6h",
                      river: "qd",
                     oppfirst: "cardback2",
                     oppsecond: "cardback2"),
            
            QuizModel(question: "Opponent has AQ of spades. You lost.",
                      answer: "B",
                      optionsList: [QuizOption(id: 51,optionId: "A", option: "Fold", color: Color.yellow),
                                    QuizOption(id: 52,optionId: "B", option: "Check", color: Color.red),
                                    QuizOption(id: 53,optionId: "C", option: "Call", color: Color.green),
                                    QuizOption(id: 54,optionId: "D", option: "Raise", color: Color.purple)],
                      yourfirst: "as",
                      yoursecond: "ah",
                      flop1: "4h",
                      flop2: "7c",
                      flop3: "9s",
                      turn: "6h",
                      river: "qd",
                     oppfirst: "as",
                     oppsecond: "qs"),
        ]
    }
}
