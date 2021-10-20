//
//  WeatherService.swift
//  WeatherExtension
//
//  Created by kayla golder on 10/20/21.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel)
    
    func didFailWithError(error: Error)
}

struct WeatherService {
//    let apiKey = "44178921fd5f00fcbc31a93644359d61"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=44178921fd5f00fcbc31a93644359d61&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //create url
        if let url = URL(string: urlString) {
            
            //create session
            let session = URLSession(configuration: .default)
            
            //give the session a task
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherName = decodedData.weather[0].value //fix?
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(weatherCondition: weatherName, temperature: temp)
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil;
        }
    }

}
