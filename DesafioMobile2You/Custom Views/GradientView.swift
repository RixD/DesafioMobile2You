//
//  GradientView.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = .black
    @IBInspectable var endColor: UIColor = .white
    @IBInspectable var startLocation: Double = 0.05
    @IBInspectable var endLocation: Double = 0.95

    
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        updatePoints()
        updateLocations()
        updateColors()
    }
}
