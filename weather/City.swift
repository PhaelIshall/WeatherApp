//
//  city.swift
//  weather
//
//  Created by Wiem Ben Rim on 6/24/17.
//  Copyright © 2017 WBR. All rights reserved.
//
import SwiftyJSON
import Foundation
class City{
    var days: [Day] = []
    
     init(json: JSON) {
        for i in 0..<7{
            let day = Day(json: json, index: i)
            if (i>0){
                let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: days[i-1].date! as Date)
                day.date = tomorrow! as NSDate
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                day.date1 = dateFormatter.string(from: day.date! as Date).capitalized
            }
            self.days.append(day)
        }
    }
}
