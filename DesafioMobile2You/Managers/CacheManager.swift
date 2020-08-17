//
//  CacheManager.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import UIKit

class CacheManager {
    static let shared   = CacheManager()
    let cache           = NSCache<NSString, UIImage>()

    private init() {}
}
