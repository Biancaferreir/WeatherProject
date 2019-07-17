//
//  Main.swift
//  Wheater
//
//  Created by Bianca on 17/07/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation

struct Main: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    let pressure: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, humidity, pressure
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
