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
    var maxProgress = 60
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    if (GameManagerVM.currentIndex < 4) {
                        GameManagerVM.currentIndex = GameManagerVM.currentIndex + 1
                        self.model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
                        //self.reset()
                        //self.start()
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
                                     
    func reset() {
        timer.invalidate()
        self.progress = 0
        //self.maxProgress = 0
    }
    
                                     
                                     
                                     
                                

}

extension GameManagerVM
{
    static var quizData: [QuizModel] {
        [
            QuizModel(question: "This is the preflop. You are the Big Blind. Opponent is a very tight preflop player. He raises 4x BB. Make your move.",
                      answer: "C",
                      optionsList: [QuizOption(id: 11,optionId: "A", option: "Fold", color: Color("tablegrey"), explain: "Since you know your opponent is preflop tight, you can narrow his hands to a few combinations. Call to see if the flop benefits him."),
                                    QuizOption(id: 12,optionId: "B", option: "Check", color: Color("tablegrey"), explain: "You cannot check after a player raises."),
                                    QuizOption(id: 13,optionId: "C", option: "Call", color: Color("tablegrey"), explain: "Call to see if the flop benefits the opponent more, or your hand."),
                                    QuizOption(id: 14,optionId: "D", option: "Raise", color: Color("tablegrey"), explain: "Your hand is not a premium. Raising here allows opponent to reraise, putting uneccessary money into the pot if the flop does not benefit you.")],
                      yourfirst: "7h",
                      yoursecond: "8h",
                      flop1: "cardback2",
                      flop2: "cardback2",
                      flop3: "cardback2",
                      turn: "cardback2",
                      river: "cardback2",
                     oppfirst: "cardback2",
                     oppsecond: "cardback2"),
            
            QuizModel(question: "Opponent now checks. What are you gonna do?",
                      answer: "D",
                      optionsList: [QuizOption(id: 21,optionId: "A", option: "Fold", color: Color("tablegrey"), explain: "Opponent checks, you do not have to fold even if you think you are weak. Check or raise instead."),
                                    QuizOption(id: 22,optionId: "B", option: "Check", color: Color("tablegrey"), explain: "Checking here is good. Opponent could be trapping with a made hand. Your middle pair is good enough to stick around for the turn."),
                                    QuizOption(id: 23,optionId: "C", option: "Call", color: Color("tablegrey"), explain: "Opponent checked, there is no bet being made. You cannot call a $0 bet. Go ahead and check or raise."),
                                    QuizOption(id: 24,optionId: "D", option: "Raise", color: Color("tablegrey"), explain: " C-betting here is ideal, in order to get more information on where your opponent stands on this all-numbers flop.")],
                      yourfirst: "7h",
                      yoursecond: "8h",
                      flop1: "4h",
                      flop2: "7c",
                      flop3: "9s",
                      turn: "cardback2",
                      river: "cardback2",
                     oppfirst: "cardback2",
                     oppsecond: "cardback2"),
            
            QuizModel(question: "You turn the world. Together with a middle pair, you have draws to the straight, as well as to the flush! Opponent checks again. How are you going to exploit this monster draw?",
                      answer: "D",
                      optionsList: [QuizOption(id: 31,optionId: "A", option: "Fold", color: Color("tablegrey"), explain: "Opponent checks, you do not have to fold even if you think you are weak. Check or raise instead."),
                                    QuizOption(id: 32,optionId: "B", option: "Check", color: Color("tablegrey"), explain: "Since you turned a very good draw, you can check to see the river card for free, to see if you hit your many draws."),
                                    QuizOption(id: 33,optionId: "C", option: "Call", color: Color("tablegrey"), explain: "Opponent checked, there is no bet being made. You cannot call a $0 bet. Go ahead and check or raise."),
                                    QuizOption(id: 34,optionId: "D", option: "Raise", color: Color("tablegrey"), explain: "Since you turned a monster draw, you can raise big here to either push your opponent out now, as you may not hit your draw on the river, or to put more money in the pot in case you hit your draw on the river.")],
                      yourfirst: "7h",
                      yoursecond: "8h",
                      flop1: "4h",
                      flop2: "7c",
                      flop3: "9s",
                      turn: "6h",
                      river: "cardback2",
                     oppfirst: "cardback2",
                     oppsecond: "cardback2"),
            
            QuizModel(question: "The Queen of Diamonds bricks all your draws. Your hand remains as middle pair. Opponent bets 3/4 pot.",
                      answer: "A",
                      optionsList: [QuizOption(id: 41,optionId: "A", option: "Fold", color: Color("tablegrey"), explain: "Folding here is a good idea, since opponent bets on a pcture card. It is more likely that QD benefits your opponent rather than you, based on preflop action."),
                                    QuizOption(id: 42,optionId: "B", option: "Check", color: Color("tablegrey"), explain: "You cannot check to a bet. Fold, call, or raise instead."),
                                    QuizOption(id: 43,optionId: "C", option: "Call", color: Color("tablegrey"), explain: "The only reason to call here is because you think the opponent is bluffing. Your hand is too weak to play against other mediocre hands."),
                                    QuizOption(id: 44,optionId: "D", option: "Raise", color: Color("tablegrey"), explain: "Raising here shows incredible strength. Do this only as a bluff, to try and kick your opponent out of the hand.")],
                      yourfirst: "7h",
                      yoursecond: "8h",
                      flop1: "4h",
                      flop2: "7c",
                      flop3: "9s",
                      turn: "6h",
                      river: "qd",
                     oppfirst: "cardback2",
                     oppsecond: "cardback2"),
            
            QuizModel(question: "Opponent has AQ of spades. You lost. Since you had a monster draw on the turn, you should have bet to kick your opponent out of the hand before he reached the river. With A-high, the tight opppnent will most likely fold to a bet.",
                      answer: "",
                      optionsList: [QuizOption(id: 51,optionId: "A", option: "Fold", color: Color("tablegrey"), explain: ""),
                                    QuizOption(id: 52,optionId: "B", option: "Check", color: Color("tablegrey"), explain: ""),
                                    QuizOption(id: 53,optionId: "C", option: "Call", color: Color("tablegrey"), explain: ""),
                                    QuizOption(id: 54,optionId: "D", option: "Raise", color: Color("tablegrey"), explain: "")],
                      yourfirst: "7h",
                      yoursecond: "8h",
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

