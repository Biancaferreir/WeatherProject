//
//  ForecastParameters.swift
//  Wheater
//
//  Created by Bianca on 28/06/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation

struct Days: Codable {
    
    static func getDaysName(sinceDate: String) -> String{
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = formater.date(from: sinceDate)!
        formater.dateFormat = "EEE"
        return formater.string(from: date)
    }
}
