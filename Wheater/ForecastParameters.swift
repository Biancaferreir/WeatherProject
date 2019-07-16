//
//  ForecastParameters.swift
//  Wheater
//
//  Created by Bianca on 28/06/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation
import UIKit

struct ListOfDays: Codable {
    let cnt: Int
    var list: [ForecastListOfDays]
    
    init(cnt: Int = 0, list: [ForecastListOfDays] = []) {
        self.cnt = cnt
        self.list = list
    }
}

struct ForecastListOfDays: Codable {
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

struct ForecastOneDay: Codable {
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

struct Weather: Codable {
    let description: String
    let icon: String
    let main: String
    let id: Int
}

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

struct Days: Codable {
    static func getDaysName(_ currentDay: String) -> String{
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = formater.date(from: currentDay)!
        formater.dateFormat = "EEE"
        return formater.string(from: date)
    }
}
