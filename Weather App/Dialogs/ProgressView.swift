//
//  PermissionDialog.swift
//  Weather App
//
//  Created by Gaurav Vyas on 26/03/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    static let shared = ProgressView()
    
    private var indicator: UIActivityIndicatorView?
    
    func setProgressView() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator?.center = self.center
        self.addSubview(indicator!)
        self.bringSubviewToFront(indicator!)
        
        indicator?.startAnimating()
        
        let label = UILabel(frame: CGRect(x: 0,
                                          y: self.center.y + indicator!.frame.height,
                                          width: bounds.width,
                                          height: 21))
        label.text = Strings.pleaseWaitLoading
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.0)
        self.addSubview(label)
    }
    
    func show(_ view: UIView) {
        self.frame = view.bounds
        view.addSubview(self)
        setProgressView()
    }
    
    func dismiss() {
        indicator?.stopAnimating()
        removeFromSuperview()
    }
}
