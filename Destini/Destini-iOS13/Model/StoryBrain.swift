//
//  StoryBrain.swift
//  Destini-iOS13
//
//  Created by Жадаев Алексей on 05.02.2023.
//

import Foundation

struct StoryBrain {
  private var sceneNumber = 0
  private let stories = [
    Story(title: "Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. You decide to hitchhike. A rusty pickup truck rumbles to a stop next to you. A man with a wide brimmed hat with soulless eyes opens the passenger door for you and asks: 'Need a ride, boy?'.", choice1: Choice(text: "I'll hop in. Thanks for the help!", nextStory: 2), choice2: Choice(text: "Better ask him if he's a murderer first.", nextStory: 1)),
    Story(title: "He nods slowly, unfazed by the question.", choice1: Choice(text: "At least he's honest. I'll climb in.", nextStory: 2), choice2: Choice(text: "Wait, I know how to change a tire.", nextStory: 3)),
    Story(title: "As you begin to drive, the stranger starts talking about his relationship with his mother. He gets angrier and angrier by the minute. He asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. He reaches for the glove box.", choice1: Choice(text: "I love Elton John! Hand him the cassette tape.", nextStory: 5), choice2: Choice(text: "It's him or me! You take the knife and stab him.", nextStory: 4)),
    Story(title: "What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?", choice1: Choice(text: "The", nextStory: 0), choice2: Choice(text: "End", nextStory: 0)),
    Story(title: "As you smash through the guardrail and careen towards the jagged rocks below you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in.", choice1: Choice(text: "The", nextStory: 0), choice2: Choice(text: "End", nextStory: 0)),
    Story(title: "You bond with the murderer while crooning verses of 'Can you feel the love tonight'. He drops you off at the next town. Before you go he asks you if you know any good places to dump bodies. You reply: 'Try the pier.'", choice1: Choice(text: "The", nextStory: 0), choice2: Choice(text: "End", nextStory: 0))
  ]
  
  mutating func getStory(with userChoice: String) -> Story {
    guard sceneNumber < stories.count else { return stories[0] }
    let story = stories[sceneNumber]
    if userChoice == story.choice1.text {
      sceneNumber = story.choice1.nextStory
    } else {
      sceneNumber = story.choice2.nextStory
    }
    return stories[sceneNumber]
  }
  
  func initialStory() -> Story {
    return stories[0]
  }
}
