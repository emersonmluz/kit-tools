//
//  WeatherModel.swift
//  kit-tools
//
//  Created by Émerson M Luz on 13/04/23.
//

import Foundation

struct WeatherModel: Decodable {
    var weather: [Weather]
    var temperature: Temperature
    var wind: Wind
    var city: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temperature = "main"
        case wind
        case city = "name"
    }
}
