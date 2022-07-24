//
//  OptionsGridView.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 24/7/22.
//

import Foundation
import SwiftUI


struct OptionsGridView: View {
    var gameManagerVM: GameManagerVM
    var columns: [GridItem] = Array(repeating: GridItem(.fixed(250), spacing: -54), count: 2)
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(gameManagerVM.model.quizModel.optionsList) { quizOption in
                OptionCardView(quizOption: quizOption)
                    .onTapGesture {
                        gameManagerVM.verifyAnswer(selectedOption: quizOption)
                    }
            }
        }
        
    }
    

}

// Tick or cross
struct OptionCardView : View {
    var quizOption: QuizOption
    var body: some View {
        VStack {
            if (quizOption.isMatched) && (quizOption.isSelected) {
                OptionStatusImageView(imageName: "")
                    .opacity(0.8)
                    .overlay {
                        Text(quizOption.explain)
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(Color("tablegrey"))
                            .frame(width: 150, height: 130, alignment: .center)
                    }
            } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
                OptionStatusImageView(imageName: "")
                    .opacity(0.8)
                    .overlay {
                        Text(quizOption.explain)
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(Color("tablegrey"))
                            .frame(width: 150, height: 130, alignment: .center)
                    }
            } else {
                OptionView(quizOption: quizOption)
            }
        }
        .frame(width: 185, height: 150)
        .background(Color("icon"))
        .cornerRadius(30)
    }
    
    // Color of the box when clicked
    func setBackgroundColor() -> Color {
        if (quizOption.isMatched) && (quizOption.isSelected) {
            return Color.green
        } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
            return Color.red
        } else {
            return Color.white
        }
    }
}

struct OptionView: View {
    var quizOption: QuizOption
    var body: some View {
        VStack{
            /*Text(quizOption.optionId)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .frame(width: 50, height: 50)
                .background(quizOption.color.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(25)*/
            
            Text(quizOption.option)
                .frame(width: 150, height: 38)
                .font(.system(size: 20, weight: .bold, design: .rounded))
        }
    }
}

struct OptionStatusImageView: View {
    var imageName: String
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
            .foregroundColor(Color.white)
    }
}
