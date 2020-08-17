//
//  DesafioMobile2YouTests.swift
//  DesafioMobile2YouTests
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import XCTest
@testable import DesafioMobile2You

class DesafioMobile2YouTests: XCTestCase {

    /// Testing fetching the Genres list
    func testGenresListCall() {
        let expectation = XCTestExpectation(description: "Get the genres list")

        let genresListProvider = TmdbMovieProvider.getGenresList
        
        let request = TmdbRequest(with: genresListProvider)
            
        request.fetchResources() { (result: Result<GenreList>) in
            switch result {
            case .success(let genresList):
                XCTAssertNotNil(genresList.genres)
                XCTAssertGreaterThan(genresList.genres!.count, 0)
            case .error(let _):
                XCTFail("getGenresList​: Failed to load the genres list")
                expectation.fulfill()
            }
        }
        

    }
    
    /// Testing fetching the main movie details
    func testMainMovieCall() {
        let movieId = 27205
        
        let expectation = XCTestExpectation(description: "Get details from a specific movie using the id")

        let movieDetailsProvider = TmdbMovieProvider.getMovieDetails​(movieId: movieId)
        
        let request = TmdbRequest(with: movieDetailsProvider)
            
        request.fetchResources() { (result: Result<Movie>) in
            switch result {
            case .success(let movieDetails):
                
                XCTAssertEqual(movieDetails.id, 27205)
                XCTAssertEqual(movieDetails.originalTitle, "Inception")
                XCTAssertEqual(movieDetails.posterPath, "/o1SB1gHCmEEURs8P6dfmSC9O3iu.jpg")
                XCTAssertNotNil(movieDetails.genres)
                
                expectation.fulfill()
                
            case .error(let error):
                XCTFail("getMovieDetails​: Failed to load the proper movie with the specific id")
                expectation.fulfill()
            }
        }
    }
    
    /// Testing live api call
    func testLiveCallSimilarMovies() {
        let expectation = XCTestExpectation(description: "Get similar movies")
        let movieId = 27205
        
        let similarMoviesProvider = TmdbMovieProvider.getSimilarMovies(movieId: movieId)
        
        let request = TmdbRequest(with: similarMoviesProvider)
        
        // API Success test
        request.fetchResources() { (result: Result<SimilarMoviesResult>) in
            switch result {
            case .success(let similarMoviesResult):
                XCTAssertGreaterThanOrEqual(similarMoviesResult.results!.count, 0)
                expectation.fulfill()
                
            case .error(let error):
                XCTFail("FetchSimilarMovies: \(error.statusMessage)")
                expectation.fulfill()
            }
        }
        


        // API Failure test
        let expectation2 = XCTestExpectation(description: "Invalid movie id")
        let invalidMovieId = 0
        
        let invalidSimilarMoviesProvider = TmdbMovieProvider.getSimilarMovies(movieId: invalidMovieId)
        
        let invalidSimilarMoviesRequest = TmdbRequest(with: invalidSimilarMoviesProvider)
        
        // API Success test
        invalidSimilarMoviesRequest.fetchResources() { (result: Result<SimilarMoviesResult>) in
            switch result {
            case .success(let similarMoviesResult):
                XCTFail("FetchInvalidSimilarMovies: loaded response with invalid id")
                expectation.fulfill()
                
                XCTAssertNil(similarMoviesResult.results)

                expectation2.fulfill()
            case .error(let error):
                XCTAssertEqual(error.statusCode!, 500)
                expectation.fulfill()
            }
        }
    }

}
