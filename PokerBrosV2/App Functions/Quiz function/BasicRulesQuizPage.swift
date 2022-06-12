//
//  BasicRulesQuizPage.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 30/5/22.
//

import UIKit

class BasicRulesQuizPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var gameModels = [Question]()
    
    var currentQuestion: Question?
    
    @IBOutlet var label : UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupQuestions()
        configureUI(question: gameModels.first!)
    }
    
    private func configureUI(question: Question) {
        label.text = question.text
        currentQuestion = question
        table.reloadData()
    }
    
    private func checkAnswer(answer: Answer, question: Question) -> Bool {
        return question.answers.contains(where: {$0.text == answer.text}) && answer.correct
    }
    
    private func setupQuestions() {
        gameModels.append(Question(text: "Can you 'Check' after another player 'Raise'?", answers: [Answer(text: "Yes", correct: false),
                      Answer(text: "No", correct: true)
        ]))
        
        gameModels.append(Question(text: "What is the total number of streets per round of poker?", answers: [Answer(text: "1", correct: false),
                      Answer(text: "2", correct: false),
                      Answer(text: "3", correct: false),
                      Answer(text: "4", correct: true)
        ]))
        
        gameModels.append(Question(text: "How many public cards are there in total per round of poker?", answers: [Answer(text: "3", correct: false),
                      Answer(text: "4", correct: false),
                      Answer(text: "5", correct: true),
                      Answer(text: "6", correct: false)
        ]))
        
        gameModels.append(Question(text: "Is a set stronger than a Straight?", answers: [Answer(text: "yes", correct: false),
             Answer(text: "no", correct: true)
        ]))
        
        gameModels.append(Question(text: "Can one win with a Three-high combination?", answers: [Answer(text: "yes", correct: false),
             Answer(text: "no", correct: true)
        ]))
        
        gameModels.append(Question(text: "Can Quads beat a Straight Flush?", answers: [Answer(text: "yes", correct: false),
             Answer(text: "no", correct: true)
        ]))
        
        gameModels.append(Question(text: "How many suits are there in a normal deck of Poker?", answers: [Answer(text: "1", correct: false),
             Answer(text: "2", correct: false),
             Answer(text: "3", correct: false),
             Answer(text: "4", correct: true)
        ]))
        
        gameModels.append(Question(text: "Is Royal Flush the same as a Straight Flush?", answers: [Answer(text: "yes", correct: false),
                      Answer(text: "no", correct: true)
        ]))
        
        gameModels.append(Question(text: "Does the pair in a Full House matters?", answers: [Answer(text: "yes", correct: true),
             Answer(text: "no", correct: false)
        ]))
        
        gameModels.append(Question(text: "The board is '3 4 5'. Player A has 'A 2', Player B has '6 7'. Who wins?", answers: [Answer(text: "Player A", correct: false),
             Answer(text: "Player B", correct: true)
        ]))
    }
    
    // Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let question = currentQuestion else {
            return
        }
        
        let answer = question.answers[indexPath.row]
            
        if checkAnswer(answer: answer, question: question) {
            // correct
            if let index = gameModels.firstIndex(where: { $0.text == question.text }) {
                if index < (gameModels.count - 1) {
                    // next question
                    let nextQuestion = gameModels[index + 1]
                    print("\(nextQuestion.text)")
                    currentQuestion = nil
                    configureUI(question: nextQuestion)
                } else {
                    // end of game
                    let alert = UIAlertController(title: "Done", message: "You are no longer a fish!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Good job!", style: .cancel, handler: nil))
                    present(alert, animated: true)
                    
                    let seconds = 2.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                        // Put your code which should be executed with a delay here
                        // transition back to BasicRulesPage
                        let quizController =
                        self.storyboard?.instantiateViewController(identifier:
                        Constants.Storyboard.quizViewController) as?
                        Quiz
                        
                        self.view.window?.rootViewController = quizController
                        self.view.window?.makeKeyAndVisible()
                    }
                    
                }
            }
        } else {
            // wrong
            let alert = UIAlertController(title: "Trolling", message: "Stop being a fish!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "I am a donkey", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
}

struct Question {
    let text : String
    let answers : [Answer]
}

struct Answer {
    let text : String
    let correct : Bool // true / false
}


