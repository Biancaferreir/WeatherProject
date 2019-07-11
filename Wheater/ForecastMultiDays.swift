//
//  WeatherDaysViewController.swift
//  Wheater
//
//  Created by Bianca on 10/07/19.
//  Copyright © 2019 Bianca. All rights reserved.
//


import Alamofire

struct ForecastMultiDays {
    static func getWeatherDays(cityID: Int, completionHandler: @escaping (Swift.Result<List, Error>) -> Void) {
        let apiKey = "f201c9049be6c17d992372ff163fd372"
        let finalURL = "https://api.openweathermap.org/data/2.5/forecast?id=\(cityID.description)&units=metric&appid=\(apiKey)&cnt=5"
        print(finalURL)
        Alamofire.request(finalURL).responseJSON(completionHandler: { response in
            do {
                let weatherAPIResult = try JSONDecoder().decode(List.self, from: response.data!)
                completionHandler(.success(weatherAPIResult))
            } catch {
                completionHandler(.failure(error))
            }
        })
    }
    

}
