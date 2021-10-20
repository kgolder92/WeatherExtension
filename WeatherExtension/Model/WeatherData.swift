//
//  WeatherData.swift
//  WeatherExtension
//
//  Created by kayla golder on 10/20/21.
// data from API

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}
