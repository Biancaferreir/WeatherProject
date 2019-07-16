//
//  ForecastAPI.swift
//  Wheater
//
//  Created by Bianca on 28/06/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation
import Alamofire

struct ForecastCurrentDay {
    
    static func getWeather(cityID: Int, completionHandler: @escaping (Swift.Result<Forecast, Error>) -> Void) {
        
        let apiKey = "f201c9049be6c17d992372ff163fd372"
        let finalURL = "https://api.openweathermap.org/data/2.5/weather?id=\(cityID.description)&units=metric&appid=\(apiKey)"
        
        Alamofire.request(finalURL).responseJSON(completionHandler: { response in
            
            do {
                let weatherAPIResult = try JSONDecoder().decode(Forecast.self, from: response.data!)
                completionHandler(.success(weatherAPIResult))
            } catch {
                completionHandler(.failure(error))
            }
        })
    }
}
    
    

