//
//  SimilarMoviesResult.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

class SimilarMoviesResult: NSObject, Codable {
    var results: [Movie]?
    var totalPages: Int?
    var currentPage: Int?
    var totalResults: Int?
    
    override init() {
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
        case totalPages = "total_pages"
        case currentPage = "page"
        case totalResults = "total_results"
    }
    

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try? container.decode([Movie].self, forKey: .results)
        self.totalPages = try? container.decode(Int.self, forKey: .totalPages)
        self.currentPage = try? container.decode(Int.self, forKey: .currentPage)
        self.totalResults = try? container.decode(Int.self, forKey: .totalResults)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(currentPage, forKey: .currentPage)
        try container.encode(totalPages, forKey: .totalPages)
        try container.encode(totalResults, forKey: .totalResults)
        try container.encode(results, forKey: .results)
    }
}
