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
        let finalURL = "https://api.openweathermap.org/data/2.5/forecast?id=\(cityID.description)&units=metric&appid=\(apiKey)&cnt=50"
        
        Alamofire.request(finalURL).responseJSON(completionHandler: { response in
            do {
                let weatherAPIResult = try JSONDecoder().decode(List.self, from: response.data!)
                var result = List()
                
                var dates: [String] = []
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                let calendar = Calendar.current
                
                for item in weatherAPIResult.list {
                    if let date = formatter.date(from: item.data) {
                        let day = calendar.component(.day, from: date)
                        let month = calendar.component(.month, from: date)
                        let year = calendar.component(.year, from: date)
                        
                        let id = "\(day)\(month)\(year)"
                        if !dates.contains(id) {
                            result.list.append(item)
                            dates.append(id)
                        } else {
                            
                        }
                    }
                }
                
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }
        })
    }
}
