//
//  ForecastTableViewCell.swift
//  Weather App
//
//  Created by Gaurav Vyas on 31/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    
    func drawCell(hourlyData: [WeatherHourData]) {
        var xCoordinate: CGFloat = 10.0

        for foreCast in hourlyData {
         
            let subView = drawSubView(xCoordinate, foreCast: foreCast)
            scrollView.addSubview(subView)
            
            xCoordinate = xCoordinate + subView.frame.width + 10
        }
        
        scrollView.contentSize.width = xCoordinate

    }
    
    private func drawSubView(_ xCoord: CGFloat, foreCast: WeatherHourData) -> UIView {
        
        let baseView = UIView(frame: CGRect(x: xCoord,
                                            y: 5,
                                            width: 50,
                                            height: 80))
        
        let timeLabel = UILabel(frame: CGRect(x: 0,
                                              y: 0,
                                              width: baseView.bounds.width,
                                              height: 20))
        timeLabel.textColor = UIColor.white
        timeLabel.text = Utils.getTimeInformat(foreCast.time)
        timeLabel.textAlignment = .center
        
        baseView.addSubview(timeLabel)
        
        let imageView = UIImageView(frame: CGRect(x: baseView.bounds.width/2 - 35/2,
                                                  y: timeLabel.frame.maxY + 3,
                                                  width: 35,
                                                  height: 35))
        imageView.image = UIImage(named: "AppLogo")
        
        baseView.addSubview(imageView)
        
        let tempLabel = UILabel(frame: CGRect(x: 0,
                                              y: imageView.frame.maxY + 3,
                                              width: baseView.bounds.width,
                                              height: 20))
        
        tempLabel.textColor = UIColor.white
        tempLabel.text = Utils.getTempInCelsius(foreCast.temperature) + " °C"
        tempLabel.textAlignment = .center
        
        baseView.addSubview(tempLabel)
        
        return baseView
    }
}
