//
//  UIView-ErrorAlertContainerView.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import UIKit

extension UIView {
    static func errorAlertContainer() -> UIView {
        let container = UIView()
        container.backgroundColor = .black
        container.layer.cornerRadius = 16
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.gray.cgColor
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }
}
