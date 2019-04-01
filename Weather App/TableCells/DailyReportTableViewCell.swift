//
//  DailyReportTableViewCell.swift
//  Weather App
//
//  Created by Gaurav Vyas on 01/04/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import UIKit

class DailyReportTableViewCell: UITableViewCell {

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    func drawCell(day: String, time: String, temperature: String, weather: String) {
        weekDayLabel.text = day
        timeLabel.text = time
        temperatureLabel.text = temperature + " °" + Strings.nextLine + weather
    }
}
