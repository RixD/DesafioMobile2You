//
//  UILabel-ErrorAlertTitle.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import UIKit

extension UILabel {
    static func titleLabel(with text: String, font: UIFont, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        
        label.textAlignment = textAlignment
        label.font = font
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text

        return label
    }
    
    static func bodyLabel(with text: String, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        
        label.textAlignment = textAlignment
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .white
        label.adjustsFontForContentSizeCategory   = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.numberOfLines  = 4
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text

        return label
    }
}
