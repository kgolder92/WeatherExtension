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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherLabel.text = ""
        temperatureLabel.text = ""
    }

    @IBAction func updateWeatherInfo(_ sender: UIButton) {

        performSegue(withIdentifier: "showLocations", sender: self)
        
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

