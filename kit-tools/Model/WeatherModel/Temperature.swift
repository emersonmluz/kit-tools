//
//  Temperature.swift
//  kit-tools
//
//  Created by Émerson M Luz on 13/04/23.
//

import Foundation

struct Temperature: Decodable {
    var temp: Float
    var tempMin: Float
    var tempMax: Float
    var humidity: Float
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}
