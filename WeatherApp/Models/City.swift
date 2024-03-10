//
//  Weather.swift
//  WeatherApp
//
//  Created by Chingiz on 08.03.24.
//

import Foundation

struct City: Codable {
    let weather: [Weather]
    var main: Temperature
    let name: String
    let timezone: Int
}

struct Weather: Codable{
    let main: String
}

struct Temperature: Codable{
    var temp: Double
    var temp_min: Double
    var temp_max: Double
}
