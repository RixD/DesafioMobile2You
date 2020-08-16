//
//  GenreList.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

struct GenreList: Codable {
    let genres: [Genres]?
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.genres = try container.decode([Genres].self, forKey: .genres)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genres, forKey: .genres)
    }
    
    func getGenre(with id: Int)-> String {
        if let genres = genres {
            for genre in genres {
                if let genreId = genre.id, genreId == id {
                    if let genreName = genre.name { return genreName }
                }
            }
        }
        return ""
    }
}
