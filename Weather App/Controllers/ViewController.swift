//
//  ViewController.swift
//  Weather App
//
//  Created by Gaurav Vyas on 26/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class ViewController: UIViewController {
    

    private var isLocationMissing = false
    private var seconds = 0
    private var timer = Timer()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTime), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    @objc private func handleTime() {
        seconds += 1
        if seconds == 5 {
            presentNextController()
        }
    }
    
    private func presentNextController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_NAME, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: Constants.WEATHER_DATA_CONTROLLER_ID) as! WeatherDataViewController
        self.present(viewController, animated: false, completion: nil)
    }
}
