//
//  weatherGetter.swift
//  weather
//
//  Created by Wiem Ben Rim on 6/21/17.
//  Copyright © 2017 WBR. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherGetter {
    var cities: [String] = []
    var city: City?
    
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/forecast/daily"
    private let openWeatherMapAPIKey = "101ab34b775d9ffd76bc55123eaea785"
    
    var working: [String] = []
    func getWeather(city: String, days: Int, onCompleted: @escaping () -> ()) {
                Alamofire.request("\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)&cnt=\(days)&units=metric").responseJSON { response in
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print(json)
                            self.city = City(json: json)
                        }
                    
                     case .failure(let error):
                        print(error)
                    }
                onCompleted()
        }

    }
    
    
    //This function gets the list of cities, this was found on OpenWeatherMaps API website
    func readTxt(){
        if let filepath = Bundle.main.path(forResource: "cities", ofType: "txt"){
            do{
            
                let contents = try String(contentsOfFile: filepath)
                let lines = contents.components(separatedBy: "\n")
                for line in lines {
                    cities.append(line)
                }

            }
            catch{
                // contents could not be loaded
            }
        }
        else{
            print("file not found")
        }
      
        
    }
    
    
}
