//
//  ReportTableViewCell.swift
//  Weather App
//
//  Created by Gaurav Vyas on 27/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func drawCell(date: String, time: String, weekDay: String, temp: String, weather: String) {
        
        cityLabel.text = Prefs.shared.getCityName()
        
        dateLabel.text = date + ", " + weekDay + " " + time
        
        temperatureLabel.text = temp + "°C"
        
        weatherLabel.text = weather
    }
}
