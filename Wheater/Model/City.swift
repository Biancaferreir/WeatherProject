//
//  City.swift
//  Wheater
//
//  Created by Bianca on 17/07/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    
    static func defaultCities() -> [City] {
        return [
            City(id: 3448439, name: "São Paulo"),
            City(id: 5367815, name: "London"),
            City(id: 5128638, name: "New York"),
            City(id: 6455259, name: "Paris"),
            City(id: 2950158, name: "Berlin"),
            City(id: 1850147, name: "Tokyo"),
            City(id: 2147714, name: "Sydney"),
            City(id: 3435910, name: "Buenos Aires"),
            City(id: 2759794, name: "Amsterdam")
        ]
    }
}
