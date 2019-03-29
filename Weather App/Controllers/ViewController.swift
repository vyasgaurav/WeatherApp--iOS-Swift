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

    private var isLocationMissing = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLocationCoordinates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setLocationCoordinates() {
        let prefs = Prefs.shared
        latitudeLabel.text = Strings.latitude + String(prefs.getLocationLatitude())
        longituteLabel.text = Strings.longitute + String(prefs.getLocationLongitute())
        
        isLocationMissing = prefs.getLocationLongitute() == 0.0 || prefs.getLocationLatitude() == 0.0
    }
    
    @IBAction func actionOnRefreshButton(_ sender: Any) {
        setLocationCoordinates()
    }
    
    @IBAction func actionOnSubmitButton(_ sender: Any) {
        
        if isLocationMissing {
            Utils.alertDialog()
            return
        }
        
        ProgressView.shared.show(self.view)
        AppServices().execute()
    }
}
