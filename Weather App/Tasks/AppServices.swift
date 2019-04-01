//
//  AppServices.swift
//  Weather App
//
//  Created by Gaurav Vyas on 26/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import Foundation
import UIKit

struct WeatherData {
    let data: WeatherCurrentData
}

struct WeatherCurrentData {
    let currentTime: Date
    let currentTemp: Double
    let currentWeather: String
    let hourData: [WeatherHourData]
    let dailyData: [WeatherDailyData]
}

struct WeatherHourData {
    let time: Date
    let temperature: Double
    let weather: String
}

struct WeatherDailyData {
    let time: Date
    let temperature: Double
    let weather: String
}

extension WeatherData {
    init?(json: [String: Any]) {
        guard let info = WeatherCurrentData(json: json) else { return nil }
        data = info
    }
}

extension WeatherCurrentData {
    init?(json: [String: Any]) {
        guard let info  = json[APIKeys.CURRENTLY] as? [String: Any],
            let time = info[APIKeys.TIME] as? Double,
            let temp = info[APIKeys.TEMPERATURE] as? Double,
            let weather = info[APIKeys.SUMMARY] as? String
            else {
                return nil
        }
        
        currentTime = Date(timeIntervalSince1970: time)
        currentTemp = temp
        currentWeather = weather
        
        var bufferData = [WeatherHourData]()

        guard let hourly = json[APIKeys.HOURLY] as? [String: Any],
            let data = hourly[APIKeys.DATA] as? [[String: Any]] else { return nil }
        
        for hourlyData in data {
            if let weatherHourlyData = WeatherHourData(json: hourlyData) {
                bufferData.append(weatherHourlyData)
            }
        }
        hourData = bufferData
        
        var weekdayData = [WeatherDailyData]()
        
        guard let daily = json[APIKeys.HOURLY] as? [String: Any],
            let values = daily[APIKeys.DATA] as? [[String: Any]] else { return nil }
        
        for jsonValue in values {
            if let weatherDailyData = WeatherDailyData(json: jsonValue) {
                weekdayData.append(weatherDailyData)
            }
        }
        dailyData = weekdayData
        print(dailyData)
    }
}

extension WeatherHourData {
    init?(json: Any) {
        guard let jsonData = json as? [String: Any], let time = jsonData[APIKeys.TIME] as? Double,
            let temp = jsonData[APIKeys.TEMPERATURE] as? Double,
            let weather = jsonData[APIKeys.SUMMARY] as? String else { return nil }
        
        self.time = Date(timeIntervalSince1970: time)
        self.temperature = temp
        self.weather = weather
    }
}

extension WeatherDailyData {
    init?(json: Any) {
        guard let jsonData = json as? [String: Any], let time = jsonData[APIKeys.TIME] as? Double,
            let temp = jsonData[APIKeys.TEMPERATURE] as? Double,
            let weather = jsonData[APIKeys.SUMMARY] as? String else { return nil }
        
        self.time = Date(timeIntervalSince1970: time)
        self.temperature = temp
        self.weather = weather
    }
}

class AppServices {
  
    func execute() {
        
        let prefs = Prefs.shared
        let serviceURL = Constants.BASE_URL + "\(prefs.getLocationLatitude()),\(prefs.getLocationLongitute())"
        
        guard let url = URL(string: serviceURL) else { return }
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                self.dismissDialog()
                return
            }

            if let object = try? JSONSerialization.jsonObject(with: data, options: []),
                let json = object as? [String: Any] {
                print(json)
                guard let weatherInfo = WeatherData(json: json)
                else {
                    self.dismissDialog()
                    return
                }
                self.dismissDialog()
                self.showWeatherReport(weatherInfo)
            }
        }
        
        dataTask.resume()
        session.finishTasksAndInvalidate()
    }
    
    private func showWeatherReport(_ weatherInfo: WeatherData) {        
        DispatchQueue.main.async {
            guard let currentViewController = AppDelegate.shared.getCurrentViewController() else { return }
            let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_NAME, bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: Constants.WEATHER_DATA_CONTROLLER_ID) as! WeatherDataViewController
            viewController.weatherInfo = weatherInfo.data
            currentViewController.present(viewController, animated: false, completion: nil)
        }
    }
    
    private func dismissDialog() {
        DispatchQueue.main.async {
            ProgressView.shared.dismiss()
        }
    }
}
