//
//  CoinManagerDelegate.swift
//  ByteCoin
//
//  Created by Жадаев Алексей on 20.02.2023.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(for rate: Double, coin: String)
}
