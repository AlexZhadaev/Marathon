//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Жадаев Алексей on 13.02.2023.
//

import UIKit

final class ResultsViewController: UIViewController {
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var settingsLabel: UILabel!
    
    private var result: Double = 0
    private var numberOfPeople: Int = 0
    private var tipPercentage: String = ""
    
    override func viewDidLoad() {
        totalLabel.text = String(format: "%.2f", result)
        settingsLabel.text = "Split between \(numberOfPeople) people, with \(tipPercentage)% tip."
    }
    
    @IBAction private func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func configure(for result: Double, with numberOfPeople: Int, tipPercentage: String) {
        self.result = result
        self.numberOfPeople = numberOfPeople
        self.tipPercentage = tipPercentage
    }
}
