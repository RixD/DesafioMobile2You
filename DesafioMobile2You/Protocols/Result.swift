//
//  Result.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(TmdbError)
}

typealias Response<T: Decodable> = (Result<T>) -> ()
