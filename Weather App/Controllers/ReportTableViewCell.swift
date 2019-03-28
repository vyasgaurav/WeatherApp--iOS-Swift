//
//  ReportTableViewCell.swift
//  Weather App
//
//  Created by Gaurav Vyas on 27/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var reportLabel: UILabel!
    
    func drawCell(date: String, time: String, temp: String, weather: String) {
        
        dateLabel.text = date
        
         let concenateString = Strings.time + " \(time)" + Strings.nextLine +
            Strings.temperature + " \(temp) C" + Strings.nextLine +
            Strings.weather + " \(weather)"
        
        reportLabel.text = concenateString
    }
}
