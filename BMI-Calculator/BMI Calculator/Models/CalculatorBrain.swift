//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Жадаев Алексей on 05.02.2023.
//

import UIKit

struct CalculatorBrain {
  var bmi: BMI?
  
  mutating func calculateBMI(height: Float, weight: Float) {
    let bmiValue = weight / pow(height, 2)
    
    switch bmiValue {
    case 12...18.5:
      bmi = BMI(value: bmiValue, advice: "Eat more pies", color: .systemBlue)
    case 18.5...24.9:
      bmi = BMI(value: bmiValue, advice: "Fit as the fiddle!", color: .systemGreen)
    case 24.9...42:
      bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: .systemRed)
    default:
      bmi = BMI(value: bmiValue, advice: "Be careful!", color: .systemPurple)
    }
  }
  
  func getBMI() -> String {
    guard let result = bmi else { return "No BMI calculated"}
    return String(format: "%.1f", result.value)
  }
  
  func getAdvice() -> String {
    guard let result = bmi else { return "No advice, sorry"}
    return result.advice
  }
  
  func getColor() -> UIColor {
    guard let result = bmi else { return .systemBackground }
    return result.color
  }
}
