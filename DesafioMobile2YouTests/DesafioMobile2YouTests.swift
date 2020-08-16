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
