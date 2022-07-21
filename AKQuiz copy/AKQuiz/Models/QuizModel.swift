//
//  QuizModel.swift
//  ShoppingAppUI
//
//  Created by richa.e.srivastava on 13/11/2021.
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
