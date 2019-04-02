//
//  WeatherDataViewController.swift
//  Weather App
//
//  Created by Gaurav Vyas on 27/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import UIKit
import CoreLocation

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
        
        fetchWeatherData()

        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)        
    }
    
    private func fetchWeatherData() {
        
        if !CLLocationManager.locationServicesEnabled() {
            Utils.alertDialog(self)
            return
        }
        
        ProgressView.shared.show(self.view)
        
        fetchLocality()
        
        AppServices().execute() { weatherInfo in
            self.weatherInfo = weatherInfo
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func fetchLocality() {
        let prefs = Prefs.shared
        let location = CLLocation(latitude: prefs.getLocationLatitude(), longitude: prefs.getLocationLongitute())
        
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            print(city + ", " + country)
            prefs.setCityName(city)
        }
    }
    
    private func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }

    @objc func handleNotification(_ notification: NotificationCenter) {
        fetchWeatherData()
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
            guard let dailyData = weatherInfo?.dailyData else { return Sections.zero.rawValue }
            return dailyData.count
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
        
        
        switch indexPath.section {
        case Sections.zero.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.REPORT_CELL_IDENTIFIER) as! ReportTableViewCell
        
            guard let info = weatherInfo else {
                return cell
            }
            
            let date = Utils.getDateInFormat(info.currentTime)
            let time = Utils.getTimeInformat(info.currentTime)
            let weekDay = Utils.getWeekDay(info.currentTime)
            let temp = Utils.getTempInCelsius(info.currentTemp)
            
            cell.drawCell(date: date, time: time, weekDay: weekDay, temp: temp, weather: info.currentWeather)
            return cell
        case Sections.one.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FORECAST_CELL_IDENTIFIER) as! ForecastTableViewCell
        
            guard let info = weatherInfo else {
                return cell
            }
            
            cell.scrollView.reloadInputViews()
            cell.drawCell(hourlyData: info.hourData)
            return cell
        case Sections.two.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DAILYREPORT_CELL_IDENTIFIER) as! DailyReportTableViewCell
            
            guard let info = weatherInfo else {
                return cell
            }
            
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
