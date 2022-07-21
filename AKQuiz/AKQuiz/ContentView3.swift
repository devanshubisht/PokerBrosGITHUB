//
//  ContentView.swift
//  AKQuiz
//
//  Created by richa.e.srivastava on 14/11/2021.
//

import SwiftUI

struct ContentView3: View {
    @ObservedObject var gameManagerVM: GameManagerVM
    var body: some View {
        ZStack {
            Image("tablebg")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        // opponent cards
                        HStack {
                            Image(gameManagerVM.model.quizModel.oppfirst)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 80, height: 50)
                                .scaledToFit()
                            
                            Image(gameManagerVM.model.quizModel.oppsecond)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 80, height: 50)
                                .scaledToFit()
                        }
                        .padding(.bottom, 280)
                        
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
                        .padding(.bottom, 350)
                    }
                )
            
            /*LinearGradient(colors: [.purple.opacity(0.4), .blue.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()*/
            if (gameManagerVM.model.quizCompleted) {
                QuizCompletedView(gameManagerVM: gameManagerVM)
            } else {
                VStack {
                    ReusableText(text: "", size: 20)
                        .padding(.top, 50)

                    ReusableText(text: gameManagerVM.model.quizModel.question, size: 12)
                        .lineLimit(3)
                        .frame(width: 310, height: 100, alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.top, 530)
                    
                    Spacer()
                
                    ZStack {
                        // users cards
                        HStack {
                            Image(gameManagerVM.model.quizModel.yourfirst)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 80, height: 50)
                                .scaledToFit()
                            
                            Image(gameManagerVM.model.quizModel.yoursecond)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 80, height: 50)
                                .scaledToFit()
                        }
                        
                        Circle()
                            .stroke(lineWidth: 10)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                            .frame(width: 50, height: 50)
                            .padding(.leading, 350)
                            .padding(.top, 77)
                        
                        
                        Circle()
                            .trim(from: 0.0, to: min(CGFloat((Double(gameManagerVM.progress) * Double(gameManagerVM.maxProgress))/100),1.0))
                            .stroke(LinearGradient(colors: [.orange, .red],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing),
                                    style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .rotationEffect(Angle(degrees: 270))
                            .animation(Animation.linear(duration: Double(gameManagerVM.maxProgress)), value: gameManagerVM.progress)
                            .frame(width: 50, height: 50)
                            .padding(.leading, 350)
                            .padding(.top, 77)
                        
                        ReusableText(text: String(gameManagerVM.progress), size: 15).opacity(0.5)
                            .frame(width: 50, height: 50)
                            .padding(.leading, 350)
                            .padding(.top, 77)
                    }
                   
                    
                    
                    Spacer()
                    
                    OptionsGridView(gameManagerVM: gameManagerVM)
                }
            }
        }
        /*.background(Image("tablebg"))
        .aspectRatio(contentMode: ContentMode.fill)
        .ignoresSafeArea() */
    }
}

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3(gameManagerVM: GameManagerVM())
    }
}

