//
//  WeatherModel.swift
//  WeatherExtension
//
//  Created by kayla golder on 10/20/21.

import Foundation

struct WeatherModel {
    let weatherCondition: String
    let temperature: Double
   
    var temperatureString: String {
        return String(format:"%.0f", temperature)
    }

}
