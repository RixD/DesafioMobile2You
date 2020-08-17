//
//  MovieDetailsViewModel.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
    var movieDetails: Movie?
    
    init(model: Movie? = nil) {
        self.movieDetails = model
    }
}

extension MovieDetailsViewModel {
    func getMovieDetails(from movieId: Int, completion: @escaping (Result<Movie>) -> Void) {
        let movieDetailsProvider = TmdbMovieProvider.getMovieDetails​(movieId: movieId)
        
        let request = TmdbRequest(with: movieDetailsProvider)
            
        request.fetchResources() { (result: Result<Movie>) in
            completion(result)
        }
    }
}
