//
//  QuizModel.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 24/7/22.
//

import Foundation
import SwiftUI

struct Quiz1 {
    var currentQuestionIndex: Int
    var quizModel: QuizModel
    var quizCompleted: Bool = false
    var quizWinningStatus: Bool = false
}

struct QuizModel {
    var question: String
    var answer: String
    var optionsList: [QuizOption]
    var yourfirst: String
    var yoursecond: String
    var flop1: String
    var flop2: String
    var flop3: String
    var turn: String
    var river: String
    var oppfirst: String
    var oppsecond: String
}

struct QuizOption : Identifiable {
    var id: Int
    var optionId: String
    var option: String
    var color: Color
    var isSelected : Bool = false
    var isMatched : Bool = false
    var explain : String
}
