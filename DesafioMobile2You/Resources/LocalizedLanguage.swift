//
//  LocalizedLanguage.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

enum Languague: String {
    case portugueseBR = "pt-BR"
    case englishUS = "en-US"
}

struct LocalizedLanguage {
    static let defaultLanguage: Languague = .portugueseBR
    
    static func getLanguageCode() -> String {
        guard let code = Locale.current.languageCode else {
            return defaultLanguage.rawValue
        }
        
        return Languague.init(rawValue: code)?.rawValue ?? defaultLanguage.rawValue
    }
}
