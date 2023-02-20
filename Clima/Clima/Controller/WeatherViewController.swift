//
//  ViewController.swift
//  Clima
//
//  Created by Жадаев Алексей on 17.02.2023.
//

import UIKit
import CoreLocation

final class WeatherViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet private weak var conditionImageView: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var searchTextField: UITextField!
    
    private var weatherManager = WeatherManager()
    private let locationManager = CLLocationManager()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    //MARK: - Interaction methods
    @IBAction private func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    //MARK: - Setup methods
    private func initialSetup() {
        setDelegates()
        temperatureLabel.textColor = UIColor(named: "weatherColor")
        initialLocationRequest()
    }
    
    private func setDelegates() {
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard textField.text == "" else { return true }
        textField.placeholder = "Please type a request"
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = textField.text else { return }
        weatherManager.fetchWeather(in: city)
        textField.text = ""
        textField.placeholder = "Search"
    }
    
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
            conditionImageView.image = UIImage(systemName: weather.imageName)
            cityLabel.text = weather.cityName
            temperatureLabel.text = weather.temperatureString
    }
    func didFailWithError(_ error: Error) {
        debugPrint(error.localizedDescription)
    }
    
}

//MARK: - CoreLocationDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    private func initialLocationRequest() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        weatherManager.fetchWeather(with: (lat, lon))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
}
