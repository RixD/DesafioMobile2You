//
//  String-formatedDateString.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

extension String {
    func getYear(from dateString: String, with format: String)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        if let date = formatter.date(from: dateString) {
            let yearFormat = "yyyy"
            formatter.dateFormat = yearFormat
            
            return formatter.string(from: date)
        } else {
            return "Data Desconhecida"
        }
    }
}
