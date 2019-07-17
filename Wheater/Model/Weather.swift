//
//  Weather.swift
//  Wheater
//
//  Created by Bianca on 17/07/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let description: String
    let icon: String
    let main: String
    let id: Int
}
