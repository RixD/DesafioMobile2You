//
//  GenresViewModel.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

class GenresViewModel {
    var genresList: GenreList?
    
    init(model: GenreList? = nil) {
        self.genresList = model
    }
}

extension GenresViewModel {
    func getGenresList(completion: @escaping (Result<GenreList>) -> Void) {
        let genresListProvider = TmdbMovieProvider.getGenresList
        
        let request = TmdbRequest(with: genresListProvider)
            
        request.fetchResources() { (result: Result<GenreList>) in
            completion(result)
        }
    }
}
