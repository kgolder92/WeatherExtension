//
//  ViewController.swift
//  WeatherExtension
//
//  Created by kayla golder on 10/19/21.
//

import UIKit

//struct Location {
//    var location: String
//}

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var city = "San Francisco"
    var country = "U.S"
    
    let locations = ["Paris, France", "Kyoto, Japan", "Sydney, Australia", "Seattle, U.S.", "New York, U.S.", "Hong Kong, Hong Kong", "Taipei, Taiwan", "London, U.K.", "Vancouver, Canada", "San Francisco, U.S."]
    
    var selectedLocation = "San Francisco, U.S."
    
    var weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherLabel.text = ""
        temperatureLabel.text = ""
        
        weatherService.delegate = self
        
        displayCurrentWeather()
    }

    func displayCurrentWeather() {
        // Update location
        cityLabel.text = city
        countryLabel.text = country
        
        // api call function create in weather service
        weatherService.fetchWeather(cityName: city)
        
    }

    @IBAction func updateWeatherInfo(_ segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! LocationTableViewController
        let selectedLocation = sourceViewController.selectedLocation.split { $0 == "," }.map { String($0) }
        city = selectedLocation[0]
        country = selectedLocation[1].trimmingCharacters(in: CharacterSet.whitespaces)
        
        displayCurrentWeather()
    }
    

    
    //MARK: - Navigation
    
    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocations" {
            let destinationController = segue.destination as! UINavigationController
            let locationTableViewController = destinationController.viewControllers[0] as! LocationTableViewController
            locationTableViewController.selectedLocation = "\(city), \(country)"
        }
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.weatherLabel.text = weather.weatherCondition
            print("made it in view controller")
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
