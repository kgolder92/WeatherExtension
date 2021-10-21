//
//  ViewController.swift
//  WeatherExtension
//
//  Created by kayla golder on 10/19/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var city = "San Francisco"
    var country = "U.S"
  
    var weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        temperatureLabel.text = "60" + "\u{00B0}"
        weatherService.delegate = self
        
        displayCurrentWeather()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayCurrentWeather() {
        cityLabel.text = city
        countryLabel.text = country
        
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
            self.temperatureLabel.text = weather.temperatureString + "\u{00B0}"
            self.weatherLabel.text = weather.weatherCondition
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
