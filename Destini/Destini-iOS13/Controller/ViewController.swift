//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var storyBrain = StoryBrain()
  
  @IBOutlet weak var storyLabel: UILabel!
  @IBOutlet weak var choice1Button: UIButton!
  @IBOutlet weak var choice2Button: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI(with: initialStory())
  }
  
  @IBAction func choiceMade(_ sender: UIButton) {
    guard let title = sender.currentTitle else { return }
    let story = getStory(with: title)
    updateUI(with: story)
  }
  
  private func updateUI(with story: Story) {
    storyLabel.text = story.title
    choice1Button.setTitle(story.choice1.text, for: .normal)
    choice2Button.setTitle(story.choice2.text, for: .normal)
  }
  
  private func getStory(with title: String) -> Story {
    storyBrain.getStory(with: title)
  }
  
  private func initialStory() -> Story {
    storyBrain.initialStory()
  }
}

