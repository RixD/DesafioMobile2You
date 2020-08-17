//
//  UIButton-ErrorAlertButton.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import UIKit

extension UIButton {
    static func errorAlertButton(with backgroundColor: UIColor, title: String) -> UIButton {
        let button = UIButton()
        
        button.backgroundColor = backgroundColor
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = backgroundColor
        button.setTitle(title, for: .normal)
        
        return button
    }
}
