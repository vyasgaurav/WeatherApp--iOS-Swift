//
//  UIApplication.swift
//  Weather App
//
//  Created by Gaurav Vyas on 30/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
