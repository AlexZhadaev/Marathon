//
//  CalculateViewController.swift
//  BMI Calculator
//
//  Created by Жадаев Алексей on 05.02.2023.
//

import UIKit

class CalculateViewController: UIViewController {
  var calculatorBrain = CalculatorBrain()
  @IBOutlet weak var heightLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  private var height: Float = 0
  private var weight: Float = 0
  
  @IBAction func heightSliderChanger(_ sender: UISlider) {
    height = sender.value
    heightLabel.text = String(format: "%.2f", height) + "m"
  }
  @IBAction func weightSliderChanged(_ sender: UISlider) {
    weight = sender.value
    weightLabel.text = String(format: "%.0f", weight) + "Kg"
  }
  
  @IBAction func calculatePressed(_ sender: UIButton) {
    calculatorBrain.calculateBMI(height: height, weight: weight)
    performSegue(withIdentifier: "goToResult", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "goToResult" else { return }
    let destinationVC = segue.destination as? ResultsViewController
    destinationVC?.bmiValue = calculatorBrain.getBMI()
    destinationVC?.advice = calculatorBrain.getAdvice()
    destinationVC?.color = calculatorBrain.getColor()
  }
}

