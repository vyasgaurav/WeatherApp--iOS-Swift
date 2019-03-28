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
    
    func setProgressView() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        self.layoutIfNeeded()
        
        let frame =  CGRect(x: 0, y: 0, width: 50, height: 50)
        
        var progressCircle = CAShapeLayer()
        
        let circleRadius : CGFloat = frame.width / 2 * 0.83
        
        let circlePath = UIBezierPath(arcCenter: self.center, radius: circleRadius, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true    )
        
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.orange.cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 3.0
        progressCircle.strokeStart = 0
        progressCircle.strokeEnd = 1.0
        self.layer.addSublayer(progressCircle)
        
        let animation = CABasicAnimation(keyPath: Strings.animationPath)
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.duration = 5.0
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        progressCircle.add(animation, forKey: Strings.animationKey)
        
        let label = UILabel(frame: CGRect(x: 0,
                                          y: self.center.y + frame.height,
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
        removeFromSuperview()
    }
}
