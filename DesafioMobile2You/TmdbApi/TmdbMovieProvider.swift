//
//  TmdbMovieProvider.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

enum TmdbMovieProvider {
    case getSimilarMovies(movieId: Int)
    case getMovieDetails​(movieId: Int)
    case getGenresList
    case getMoviePosterImage(posterPath: String, size: String)
}

extension TmdbMovieProvider: Endpoint {
    var version: Int {
        return TmdbConfig.version
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var params: [String : Any]? {
        switch self {
        case .getSimilarMovies(let movieId):
            return ["movie_id": movieId]
        case .getMovieDetails​(let movieId):
            return ["movie_id": movieId]
        case .getGenresList:
            return nil
        case .getMoviePosterImage:
            return nil
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var baseUrl: String {
        switch self {
        case .getSimilarMovies, .getMovieDetails​, .getGenresList:
            return TmdbConfig.tmdbBaseUrl
        case .getMoviePosterImage:
            return TmdbConfig.tmdbBaseImageUrl
        }
    }

    var path: String {
        switch self {
        case .getSimilarMovies(let movieId):
            return "/\(version)/movie/\(movieId)/similar"
        case .getMovieDetails​(let movieId):
            return "/\(version)/movie/\(movieId)"
        case .getGenresList:
            return "/\(version)/genre/movie/list"
        case .getMoviePosterImage(let posterPath, let size):
            return "/t/p/\(size)\(posterPath)"
        }
    }
}


