//
//  TmdbRequest.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

class TmdbRequest: NSObject {
    private let _movieProvider: TmdbMovieProvider
    private let urlSession = URLSession.shared
    
    init(with movieProvider: TmdbMovieProvider) {
        _movieProvider = movieProvider
    }
    
    public func fetchResources<T: Decodable>(completion: @escaping (Result<T>) -> Void) {
        guard let urlRequest = _movieProvider.urlRequest else {
            completion(Result.error(TmdbError.defaultModel))
            return
        }

        urlSession.dataTask(with: urlRequest) { (result) in
            switch result {
                case .success(let (response, data)):
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                        let errorCode = (response as? HTTPURLResponse)?.statusCode
                                            
                        switch errorCode {
                        case 400:
                            completion(Result.error(TmdbError.FailedRequest))
                        case 401:
                            completion(Result.error(TmdbError.Unauthorized))
                        case 404:
                            completion(Result.error(TmdbError.NotFound))
                        default:
                            completion(Result.error(TmdbError.defaultModel))
                        }
                        
                        return
                    }
                        
                    let jsonDecoder = JSONDecoder()
                    do {
                        let model = try jsonDecoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(Result.success(model))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(Result.error(TmdbError.defaultModel))
                        }
                    }
            case .failure( _):
                    completion(Result.error(TmdbError.defaultModel))
            }
        }.resume()
    }
}
