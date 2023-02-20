//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Жадаев Алексей on 13.02.2023.
//

import UIKit

final class CalculatorViewController: UIViewController {
    @IBOutlet private weak var billTextField: UITextField!
    @IBOutlet private weak var twentyPctButton: UIButton!
    @IBOutlet private weak var tenPctButton: UIButton!
    @IBOutlet private weak var zeroPctButton: UIButton!
    @IBOutlet private weak var splitNumberLabel: UILabel!
    private var tippedSum: Double = 0
    private var result: Double = 0
    private var numberOfPeople: Int = 0
    private var tipPercentage: String = ""
    
    
    @IBAction private func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        guard var tipString = sender.currentTitle else { return }
        tipString.removeLast()
        tipPercentage = tipString
    }
    
    @IBAction private func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction private func calculatePressed(_ sender: UIButton) {
        guard let billSumString = billTextField.text, let billSumDouble = Double(billSumString) else { return }
        guard let tipDouble = Double(tipPercentage) else { return }
        tippedSum = billSumDouble * (1.0 + (tipDouble / 100))
        guard let splitString = splitNumberLabel.text, let splitNumber = Double(splitString) else { return }
        numberOfPeople = Int(splitNumber)
        result = calculate(from: tippedSum, divided: splitNumber)
        performSegue(withIdentifier: "toResultsVC", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toResultsVC" else { return }
        let destinationVC = segue.destination as! ResultsViewController
        destinationVC.configure(for: result, with: numberOfPeople, tipPercentage: tipPercentage)
    }
    
    private func calculate(from sum: Double, divided by: Double) -> Double {
        return sum / by
    }
}

