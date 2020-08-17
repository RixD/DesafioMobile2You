//
//  SimilarMoviesViewModel.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

class SimilarMoviesViewModel {
    var similarMovies: SimilarMoviesResult?
    
    init(model: SimilarMoviesResult? = nil) {
        self.similarMovies = model
    }
}

extension SimilarMoviesViewModel {
    func getSimilarMovies(from movieId: Int, completion: @escaping (Result<SimilarMoviesResult>) -> Void) {
        let similarMoviesProvider = TmdbMovieProvider.getSimilarMovies(movieId: movieId)
        
        let request = TmdbRequest(with: similarMoviesProvider)
            
        request.fetchResources() { (result: Result<SimilarMoviesResult>) in
            completion(result)
        }
    }
}
