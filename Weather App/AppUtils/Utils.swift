//
//  Utils.swift
//  Weather App
//
//  Created by Gaurav Vyas on 27/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import Foundation

class Utils {
    
    static func getDateInFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DATE_FORMATE
        return dateFormatter.string(from: date)
    }
    
    static func getTimeInformat(_ date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = Constants.TIME_FORMATE
        return timeFormatter.string(from: date)
    }
    
    static func getTempInCelsius(_ temp: Double) -> String {
        let temperature = Int(5.0 / 9.0 * (temp - 32.0))
        return String(temperature)
    }
}
