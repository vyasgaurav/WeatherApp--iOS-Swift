//
//  WeatherDataViewController.swift
//  Weather App
//
//  Created by Gaurav Vyas on 27/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import UIKit

class WeatherDataViewController: UIViewController {

    var weatherInfo: WeatherCurrentData!
    
    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension WeatherDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 100
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let info = weatherInfo else {
            return UITableViewCell()
        }

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.REPORT_CELL_IDENTIFIER) as! ReportTableViewCell
            
            let date = Utils.getDateInFormat(info.currentTime)
            let time = Utils.getTimeInformat(info.currentTime)
            let weekDay = Utils.getWeekDay(info.currentTime)
            let temp = Utils.getTempInCelsius(info.currentTemp)
            
            cell.drawCell(date: date, time: time, weekDay: weekDay, temp: temp, weather: info.currentWeather)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FORECAST_CELL_IDENTIFIER) as! ForecastTableViewCell
            
            cell.drawCell(hourlyData: info.hourData)
            return cell

        default:
            return UITableViewCell()
        }
      
//        if indexPath.section == 0 {
//            let date = Utils.getDateInFormat(info.currentTime)
//            let time = Utils.getTimeInformat(info.currentTime)
//            let temp = Utils.getTempInCelsius(info.currentTemp)
//
//            cell.drawCell(time: info.currentTime, temp: temp, weather: info.currentWeather)
//            return cell
//        } else {
//            let date = Utils.getDateInFormat(forecast.time)
//            let time = Utils.getTimeInformat(forecast.time)
//            let temp = Utils.getTempInCelsius(forecast.temperature)
//
//            cell.drawCell(time: forecast.time, temp: temp, weather: forecast.weather)
//            return cell
//        }
    }
}
