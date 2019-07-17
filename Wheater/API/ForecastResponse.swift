//
//  ForecastResponse.swift
//  Wheater
//
//  Created by Bianca on 17/07/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation

struct ForecastResponse: Decodable {
    
    var list: [ForecastItem] = []
    
}
