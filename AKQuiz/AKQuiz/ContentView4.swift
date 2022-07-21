//
//  ContentView.swift
//  AKQuiz
//
//  Created by richa.e.srivastava on 14/11/2021.
//

import SwiftUI

struct ContentView4: View {
    @ObservedObject var gameManagerVM: GameManagerVM
    var body: some View {
        ZStack {
            Image("shortertablebg")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                .ignoresSafeArea()
                .overlay {
                    ZStack {
                        // Opponent cards
                        HStack {
                            Image(gameManagerVM.model.quizModel.oppfirst)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 60, height: 30)
                                .scaledToFit()
                            
                            Image(gameManagerVM.model.quizModel.oppsecond)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 60, height: 30)
                                .scaledToFit()
                        }
                        .padding(.bottom, 770)
                        .padding(.leading, 200)
                        
                        // board cards
                        HStack {
                            Image(gameManagerVM.model.quizModel.flop1)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 50, height: 50)
                                .scaledToFit()
                            
                            Image(gameManagerVM.model.quizModel.flop2)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 50, height: 50)
                                .scaledToFit()
                            
                            Image(gameManagerVM.model.quizModel.flop3)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 50, height: 50)
                                .scaledToFit()
                            
                            Image(gameManagerVM.model.quizModel.turn)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 50, height: 50)
                                .scaledToFit()
                            
                            Image(gameManagerVM.model.quizModel.river)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 50, height: 50)
                                .scaledToFit()
                            
                        }
                        .padding(.bottom, 300)
                        
                        // users cards
                        HStack {
                            Image(gameManagerVM.model.quizModel.yourfirst)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 60, height: 30)
                                .scaledToFit()
                            
                            Image(gameManagerVM.model.quizModel.yoursecond)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 60, height: 30)
                                .scaledToFit()
                        }
                        .padding(.top, 150)
                        .padding(.trailing, 200)
                    }
                }
            
            /*LinearGradient(colors: [.purple.opacity(0.4), .blue.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()*/
            if (gameManagerVM.model.quizCompleted) {
                QuizCompletedView(gameManagerVM: gameManagerVM)
            } else {
                VStack {
                    /*ReusableText(text: "Animal Knowledge Quiz!", size: 30)
                        .padding()*/
                    
                    // Narrative text
                    ReusableText(text: gameManagerVM.model.quizModel.question, size: 12)
                        .lineLimit(5)
                        .frame(width: 310, height: 60)
                        .multilineTextAlignment(.center)
                        .padding(.top, 400)
                    
                    Spacer()
                    
                    // Circle timer
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 3)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        
                        Circle()
                            .trim(from: 0.0, to: min(CGFloat((Double(gameManagerVM.progress) * Double(gameManagerVM.maxProgress))/100),1.0))
                            .stroke(LinearGradient(colors: [.orange, .red],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing),
                                    style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                            .rotationEffect(Angle(degrees: 270))
                            .animation(Animation.linear(duration: Double(gameManagerVM.maxProgress)), value: gameManagerVM.progress)
                        
                        ReusableText(text: String(gameManagerVM.progress), size: 15)
                    }
                    .frame(width: 40, height: 40)
                    .padding(.top, 100)
                    .padding(.leading, 365)
                    
                    
                    
                    //Spacer()
                    
                    OptionsGridView(gameManagerVM: gameManagerVM)
                        .padding(.bottom, 35)
                }
            }
        }
    }
}

struct ContentView4_Previews: PreviewProvider {
    static var previews: some View {
        ContentView4(gameManagerVM: GameManagerVM())
    }
}

