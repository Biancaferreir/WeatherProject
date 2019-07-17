//
//  ForecastAPI.swift
//  Wheater
//
//  Created by Bianca on 28/06/19.
//  Copyright © 2019 Bianca. All rights reserved.
//

import Foundation
import Alamofire

struct OpenWeatherAPI {
    
    private init() { }
    
    static func weather(cityID: Int, completionHandler: @escaping (Swift.Result<ForecastWeather, Error>) -> Void) {
        
        let finalURL = "\(APIConstants.baseURL)/weather?id=\(cityID.description)&units=\(APIConstants.apiMetrics)&appid=\(APIConstants.apiKey)"
        Alamofire.request(finalURL).responseJSON(completionHandler: { response in
            
            do {
                let apiResponse = try JSONDecoder().decode(ForecastWeather.self, from: response.data!)
                completionHandler(.success(apiResponse))
            } catch {
                completionHandler(.failure(error))
            }
        })
    }
    
    static func forecast(cityID: Int, completionHandler: @escaping (Swift.Result<ForecastResponse, Error>) -> Void) {
        
        let finalURL = "\(APIConstants.baseURL)/forecast?id=\(cityID.description)&units=\(APIConstants.apiMetrics)&appid=\(APIConstants.apiKey)"
        
        Alamofire.request(finalURL).responseJSON(completionHandler: { response in
            do {
                let apiResponse = try JSONDecoder().decode(ForecastResponse.self, from: response.data!)
                
                var result = ForecastResponse()
                
                var dates: [String] = []
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                let calendar = Calendar.current
                
                for item in apiResponse.list {
                    
                    if let date = formatter.date(from: item.date) {
                        let day = calendar.component(.day, from: date)
                        let month = calendar.component(.month, from: date)
                        let year = calendar.component(.year, from: date)
                        
                        // TODO: arrumar para conseguir a tempMax e Min do dia
                        let id = "\(day)\(month)\(year)"
                        if !dates.contains(id) {
                            result.list.append(item)
                            dates.append(id)
                        } else {
                            // FIX-ME: lidar com isso
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

