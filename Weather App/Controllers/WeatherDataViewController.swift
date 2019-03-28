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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func actionOnBackButton(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}

extension WeatherDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return weatherInfo.hourData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.REPORT_CELL_IDENTIFIER) as! ReportTableViewCell
        
        guard let info = weatherInfo else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            let date = Utils.getDateInFormat(info.currentTime)
            let time = Utils.getTimeInformat(info.currentTime)
            let temp = Utils.getTempInCelsius(info.currentTemp)
            
            cell.headerLabel.text = Strings.current
            cell.drawCell(date: date, time: time, temp: temp, weather: info.currentWeather)
            return cell
        } else {
            let forecast = info.hourData[indexPath.row]
            let date = Utils.getDateInFormat(forecast.time)
            let time = Utils.getTimeInformat(forecast.time)
            let temp = Utils.getTempInCelsius(forecast.temperature)
            
            cell.headerLabel.text = indexPath.row == 0 ? Strings.forecast : Strings.empty
            cell.drawCell(date: date, time: time, temp: temp, weather: forecast.weather)
            return cell
        }
    }
}
