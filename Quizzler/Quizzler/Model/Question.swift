//
//  Question.swift
//  Quizzler
//
//  Created by Жадаев Алексей on 03.02.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
  let text: String
  let answers: [String]
  let answer: String
  
  init(q: String, a: [String], correctAnswer: String) {
    text = q
    answers = a
    answer = correctAnswer
  }
}
