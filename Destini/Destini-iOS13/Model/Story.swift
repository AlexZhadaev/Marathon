//
//  Story.swift
//  Destini-iOS13
//
//  Created by Жадаев Алексей on 05.02.2023.
//

import Foundation

struct Story {
  let title: String
  let choice1: Choice
  let choice2: Choice
}

struct Choice {
  let text: String
  let nextStory: Int
}
