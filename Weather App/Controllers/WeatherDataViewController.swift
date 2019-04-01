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
    
    private static let SECTIONS = 3
    
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
        return WeatherDataViewController.SECTIONS
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.zero.rawValue:
            return Sections.one.rawValue
        case Sections.one.rawValue:
            return Sections.one.rawValue
        case Sections.two.rawValue:
            return weatherInfo.dailyData.count
        default:
            return Sections.zero.rawValue
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Sections.zero.rawValue:
            return 300
        case Sections.one.rawValue:
            return 100
        case Sections.two.rawValue:
            return 60
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let info = weatherInfo else {
            return UITableViewCell()
        }

        switch indexPath.section {
        case Sections.zero.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.REPORT_CELL_IDENTIFIER) as! ReportTableViewCell
        
            let date = Utils.getDateInFormat(info.currentTime)
            let time = Utils.getTimeInformat(info.currentTime)
            let weekDay = Utils.getWeekDay(info.currentTime)
            let temp = Utils.getTempInCelsius(info.currentTemp)
            
            cell.drawCell(date: date, time: time, weekDay: weekDay, temp: temp, weather: info.currentWeather)
            return cell
        case Sections.one.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FORECAST_CELL_IDENTIFIER) as! ForecastTableViewCell
        
            cell.drawCell(hourlyData: info.hourData)
            return cell
        case Sections.two.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DAILYREPORT_CELL_IDENTIFIER) as! DailyReportTableViewCell
            
            let data = info.dailyData[indexPath.row]
            let weekDay = Utils.getWeekDay(data.time)
            let temp = Utils.getTempInCelsius(data.temperature)
            let time = Utils.getTimeInformat(data.time)

            cell.drawCell(day: weekDay, time: time, temperature: temp, weather: data.weather)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
