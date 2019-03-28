//
//  Prefs.swift
//  Weather App
//
//  Created by Gaurav Vyas on 26/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import Foundation

public class Prefs {
    
    static let shared = Prefs()
    
    private static let LATITUDE = "latitude"
    private static let LONGITUTE = "longitute"
    
    private var preferences = UserDefaults()
    
    private init() {}
    
    func setLocationLatitude(latitude: Double) {
        preferences.set(latitude, forKey: Prefs.LATITUDE)
    }
    
    func getLocationLatitude() -> Double {
        return preferences.double(forKey: Prefs.LATITUDE)
    }
    
    func setLocationLongitute(longitute: Double) {
        preferences.set(longitute, forKey: Prefs.LONGITUTE)
    }
    
    func getLocationLongitute() -> Double {
        return preferences.double(forKey: Prefs.LONGITUTE)
    }
}
