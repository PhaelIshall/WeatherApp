//
//  Day.swift
//  weather
//
//  Created by Wiem Ben Rim on 6/24/17.
//  Copyright © 2017 WBR. All rights reserved.
//

import Foundation
//
//  city.swift
//  weather
//
//  Created by Wiem Ben Rim on 6/24/17.
//  Copyright © 2017 WBR. All rights reserved.
//
import SwiftyJSON
import Foundation
class Day{
    var day: Double?
    var min: Double?
    var max: Double?
    var night: Double?
    var eve: Double?
    var morn: Double?
    var icon: String?
    var description: String?
    var iconLink: String?
    var date1: String?
    var date: NSDate?
    
    init(json: JSON, index: Int) {
        day = json["list"][index]["temp"]["day"].double ?? 0.0
        min = json["list"][index]["temp"]["min"].double ?? 0.0
        max = json["list"][index]["temp"]["max"].double ?? 0.0
        night = json["list"][index]["temp"]["night"].double ?? 0.0
        eve = json["list"][index]["temp"]["eve"].double ?? 0.0
        morn = json["list"][index]["temp"]["morn"].double ?? 0.0
        icon = json["list"][index]["weather"][0]["icon"].string ?? ""
        iconLink = "http://openweathermap.org/img/w/" + icon! + ".png"
        description = json["list"][index]["weather"][0]["description"].string ?? ""
        let d = json["list"][0]["dt"].double ?? 0.0
        self.date = NSDate(timeIntervalSince1970: d)
        date1 = "Today"      
    }
}
