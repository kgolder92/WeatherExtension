//
//  WeatherData.swift
//  WeatherExtension
//
//  Created by kayla golder on 10/20/21.
//  Weather Data
//  data from API to parse

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
