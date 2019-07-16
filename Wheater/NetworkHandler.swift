//
//  ForecastAPI.swift
//  Wheater
//
//  Created by Bianca on 28/06/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation
import Alamofire

private let apiKey = "&appid=f201c9049be6c17d992372ff163fd372"
private let oneDayURL = "https://api.openweathermap.org/data/2.5/weather?id="
private let fiveDaysURL = "https://api.openweathermap.org/data/2.5/forecast?id="
private let apiMetrics = "&units=metric"

struct NetworkHandler {
    
    static func forecastForOneDay(cityID: Int, completionHandler: @escaping (Swift.Result<ForecastOneDay, Error>) -> Void) {
        
        let finalURL = "\(oneDayURL)\(cityID.description)\(apiMetrics)\(apiKey)"
        
        Alamofire.request(finalURL).responseJSON(completionHandler: { response in
            
            do {
                let apiResponse = try JSONDecoder().decode(ForecastOneDay.self, from: response.data!)
                completionHandler(.success(apiResponse))
            } catch {
                completionHandler(.failure(error))
            }
        })
    }
    
    static func forecastForFiveDays(cityID: Int, completionHandler: @escaping (Swift.Result<ListOfDays, Error>) -> Void) {
        
        let finalURL = "\(fiveDaysURL)\(cityID.description)\(apiMetrics)\(apiKey)"
            
        Alamofire.request(finalURL).responseJSON(completionHandler: { response in
            do {
                let apiResponse = try JSONDecoder().decode(ListOfDays.self, from: response.data!)
                
                var result = ListOfDays()
                
                var dates: [String] = []
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                let calendar = Calendar.current
                
                for item in apiResponse.list {
                    if let date = formatter.date(from: item.date) {
                        let day = calendar.component(.day, from: date)
                        let month = calendar.component(.month, from: date)
                        let year = calendar.component(.year, from: date)
                        
                        //arrumar para conseguir a tempMax e Min do dia
                        let id = "\(day)\(month)\(year)"
                        if !dates.contains(id) {
                            result.list.append(item)
                            dates.append(id)
                        } else {
                            //lidar com isso
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
    
    

