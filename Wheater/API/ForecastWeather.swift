//
//  ForecastWeather.swift
//  Wheater
//
//  Created by Bianca on 17/07/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation
import UIKit

struct ForecastWeather: Codable {
    
    let weather: [Weather]
    let main: Main
    let cod: Int
    let id: Int
    let dt: Int
    let timezone: Int
    let name: String
    
    var icon: UIImage? {
        let data = try? Data(contentsOf: imageURL!)
        let icon = UIImage(data: data!)
        return icon
    }
    
    var imageURL: URL? {
        if let weather = weather.first {
            return URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")
        }
        return nil
    }
}
