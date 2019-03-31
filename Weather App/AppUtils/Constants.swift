//
//  Constants.swift
//  Weather App
//
//  Created by Gaurav Vyas on 26/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import Foundation

class Constants {
    
    static let API_SECRET_KEY = "ab3b8d3ba5378aba59863e67ec60a5bb"
    static let BASE_URL = "https://api.darksky.net/forecast/" + Constants.API_SECRET_KEY + "/"
    
    static let STORYBOARD_NAME = "Main"
    static let WEATHER_DATA_CONTROLLER_ID = "WeatherDataViewController"
    static let REPORT_CELL_IDENTIFIER = "ReportTableViewCell"
    static let FORECAST_CELL_IDENTIFIER = "ForecastTableViewCell"
    
    static let DATE_FORMATE = "yyyy-MM-dd"
    static let TIME_FORMATE = "HH:mm"
}
