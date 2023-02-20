//
//  WeatherManager.swift
//  Clima
//
//  Created by Жадаев Алексей on 17.02.2023.
//

import Foundation

private enum Constants {
    static let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=b5b8ceed570a92689e6b3dc0660c31f8"
}

struct WeatherManager {
    //MARK: - Properties
    private let decoder = JSONDecoder()
    
    var delegate: WeatherManagerDelegate?
    
    //MARK: - Fetching methods
    func fetchWeather(in city: String) {
        let urlString = Constants.weatherURL + "&q=\(city)"
        DispatchQueue.global().async {
            performRequest(with: urlString)
        }
    }
    
    func fetchWeather(with coordinates: (lat: Double, lon: Double)) {
        let urlString = Constants.weatherURL + "&lat=\(coordinates.lat)&lon=\(coordinates.lon)"
        DispatchQueue.global().async {
            performRequest(with: urlString)
        }
    }
 //MARK: - URLSession
    private func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                debugPrint("error in request")
                delegate?.didFailWithError(error)
                return
            }
            guard let data = data, let weather = parseJSON(from: data) else { return }
            DispatchQueue.main.async {
                delegate?.didUpdateWeather(self, weather: weather)
            }
        }
        task.resume()
    }
 //MARK: - JSON decoding
    private func parseJSON(from data: Data) -> WeatherModel? {
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(WeatherDataModel.self, from: data)
            let id = decodedData.weather[0].id
            let city = decodedData.name
            let condition = decodedData.weather[0].description
            let temp = decodedData.main.temp
            let feel = decodedData.main.feelsLike
            let weather = WeatherModel(conditionId: id, temperature: temp, feelsLike: feel, cityName: city, conditionName: condition)
            return weather
        } catch {
            debugPrint("error in parse")
            delegate?.didFailWithError(error)
        }
        return nil
    }
}
