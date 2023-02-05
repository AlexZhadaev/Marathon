//
//  RootViewController.swift
//  Quizzler
//
//  Created by Жадаев Алексей on 03.02.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var progressBar: UIProgressView!
  @IBOutlet weak var answerButton1: UIButton!
  @IBOutlet weak var answerButton2: UIButton!
  @IBOutlet weak var answerButton3: UIButton!
  
  private var quizLogic = QuizLogic()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  @IBAction func answerButtonPressed(_ sender: UIButton) {
    defer {
      answerButton1.isUserInteractionEnabled = false
      answerButton2.isUserInteractionEnabled = false
      answerButton3.isUserInteractionEnabled = false
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.updateUI()
      }
    }
    checkAnswer(withSender: sender)
    getNextQuestion()
  }
  
  
  private func checkAnswer(withSender sender: UIButton) {
    guard let chosenAnswer = sender.currentTitle else { return }
    if quizLogic.checkAn(answer: chosenAnswer) {
      sender.backgroundColor = .systemGreen
    } else {
      sender.backgroundColor = .systemRed
    }
  }
  
  private func getNextQuestion() {
    quizLogic.nextQuestion()
  }
  
  private func updateProgressBar() {
    progressBar.progress = quizLogic.getProgress()
  }
  
  private func updateUI() {
    questionLabel.text = quizLogic.getQuestion()
    scoreLabel.text = quizLogic.getScore()
    setupButtons([answerButton1, answerButton2, answerButton3])
    updateProgressBar()
  }
  
  private func setupButtons(_ buttons: [UIButton]) {
    for index in buttons.indices {
      buttons[index].backgroundColor = .clear
      buttons[index].isUserInteractionEnabled = true
      buttons[index].setTitle(quizLogic.getTitle(for: index), for: .normal)
    }
  }
  
}

