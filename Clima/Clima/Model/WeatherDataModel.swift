//
//  WeatherDataModel.swift
//  Clima
//
//  Created by Жадаев Алексей on 17.02.2023.
//

import Foundation

struct WeatherDataModel: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}

extension WeatherDataModel {
    struct Weather: Decodable {
        let id: Int
        let description: String
    }
    
    struct Main: Decodable {
        let temp: Double
        let feelsLike: Double
    }
}
