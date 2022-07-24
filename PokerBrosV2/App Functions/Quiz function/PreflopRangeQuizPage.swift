//
//  PreflopRangeQuizPage.swift
//  PokerBrosV2
//
//  Created by Ang Yuze on 10/6/22.
//

import UIKit

class PreflopRangeQuizPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var gameModels = [Question1]()
    
    var currentQuestion: Question1?
    
    @IBOutlet var label : UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupQuestions()
        configureUI(question: gameModels.first!)
    }
    
    private func configureUI(question: Question1) {
        label.text = question.text
        currentQuestion = question
        table.reloadData()
    }
    
    private func checkAnswer(answer: Answer1, question: Question1) -> Bool {
        return question.answers.contains(where: {$0.text == answer.text}) && answer.correct
    }
    
    private func setupQuestions() {
        gameModels.append(Question1(text: "What does the 'Poker Matrix' show?",
            answers: [Answer1(text: "Random numbers and alphabets", correct: false),
                      Answer1(text: "Probability of any possible starting hand", correct: true),
                      Answer1(text: "Tells the future", correct: false)
        ]))
        
        gameModels.append(Question1(text: "How many possible starting hands are there, not considering suits?",answers: [
                      Answer1(text: "104", correct: false),
                      Answer1(text: "169", correct: true),
                      Answer1(text: "240", correct: false)
        ]))
        
        gameModels.append(Question1(text: "When a very tight player open raises pre flop, should you be careful navigating through post flop?",
            answers: [
                      Answer1(text: "For sure", correct: true),
                      Answer1(text: "Nope he is a coward", correct: false)
        ]))
        
        gameModels.append(Question1(text: "Would you want to 3-bet a tight player that open raises with 7 10 offsuit?",
    answers: [Answer1(text: "yes", correct: false),
             Answer1(text: "no", correct: true)
        ]))
        
        gameModels.append(Question1(text: "How many unique combinations of starting hands are there, considering suits?",
    answers: [Answer1(text: "1048", correct: false),
             Answer1(text: "1326", correct: true),
              Answer1(text: "1894", correct: false)
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

struct Question1 {
    let text : String
    let answers : [Answer1]
}

struct Answer1 {
    let text : String
    let correct : Bool // true / false
}

