//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    var pickerAnswer: Bool = false
    var questionNumber: Int = 0
    var score : Int = 0
    var progressValue = 0.0
    
    let allQuestions = QuestionBank()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let firtQuestion = allQuestions.list[questionNumber]
        questionLabel.text = firtQuestion.questionText
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickerAnswer = true
        }
        else if sender.tag == 2 {
            pickerAnswer = false
        }
        
        checkAnswer()
        questionNumber += 1
        nextQuestion()
        
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score : \(score)"
        progressLabel.text = "\(questionNumber + 1) / \(allQuestions.list.count)"
        progressBar.setProgress(Float(questionNumber + 1) / Float(allQuestions.list.count), animated: true)
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over ?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer != pickerAnswer {
            ProgressHUD.showError("Wrong !")
        } else {
            ProgressHUD.showSuccess("Correct !")
            score += 1
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        progressBar.progress = Float(1) / Float(allQuestions.list.count)
        nextQuestion()
    }
    

    
}
