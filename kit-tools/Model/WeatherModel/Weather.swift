//
//  Weather.swift
//  kit-tools
//
//  Created by Émerson M Luz on 13/04/23.
//

import Foundation

struct Weather: Decodable {
    var state: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case state = "main"
        case description
    }
}
