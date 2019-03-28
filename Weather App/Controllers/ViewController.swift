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
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longituteLabel: UILabel!
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLocationCoordinates()
    }
    
    private func initializeLocationManager() {
        
        // Ask for authorisation from the user.
        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func setLocationCoordinates() {
        let prefs = Prefs.shared
        latitudeLabel.text = Strings.latitude + String(prefs.getLocationLatitude())
        longituteLabel.text = Strings.longitute + String(prefs.getLocationLongitute())
    }
    
    @IBAction func actionOnRefreshButton(_ sender: Any) {
        setLocationCoordinates()
    }
    
    @IBAction func actionOnSubmitButton(_ sender: Any) {
        ProgressView.shared.show(self.view)
        AppServices().execute()
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue = manager.location?.coordinate else { return }
        Prefs.shared.setLocationLatitude(latitude: locationValue.latitude)
        Prefs.shared.setLocationLongitute(longitute: locationValue.longitude)
    }
}
