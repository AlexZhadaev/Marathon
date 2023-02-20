//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Жадаев Алексей on 20.02.2023.
//

import Foundation

struct CoinManager {
    var delegate: CoinManagerDelegate?
    let decoder = JSONDecoder()
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "54F3EBEC-CDF0-4B7A-9C86-239EE6CA0BA0"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = baseURL + "/\(currency)" + "?apikey=\(apiKey)"
        DispatchQueue.global().async {
            performRequest(with: urlString, coin: currency)
        }
    }
    //MARK: - URLSession
    func performRequest(with urlString: String, coin: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            guard let data = data, let rate = parseJSON(from: data) else { return }
            DispatchQueue.main.async {
                delegate?.didUpdateCurrency(for: rate, coin: coin)
            }
        }
        task.resume()
    }
    
    //MARK: - JSON decoding
    private func parseJSON(from data: Data) -> Double? {
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            return lastPrice
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
