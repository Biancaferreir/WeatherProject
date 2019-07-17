//
//  ForecastItem.swift
//  Wheater
//
//  Created by Bianca on 17/07/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation
import UIKit

struct ForecastItem: Decodable {
    
    let main: Main
    let weather: [Weather]
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case date = "dt_txt"
    }
    
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
