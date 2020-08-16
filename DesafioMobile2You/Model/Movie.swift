//
//  Movie.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id: Int
    var title: String
    var originalTitle: String
    var overview: String
    var releaseDate: String

    var backdropPath: String
    var posterPath: String

    var voteCount: Int
    var voteAverage: Float
    
    var popularity: Float

    var genres: [Genres?]?
    
    var genreIds: [Int?]?

    var adult: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        
        case popularity
        
        case genres
        case genreIds = "genre_ids"
        
        case adult
    }
}
