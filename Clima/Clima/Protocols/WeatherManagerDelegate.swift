//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Жадаев Алексей on 17.02.2023.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}
