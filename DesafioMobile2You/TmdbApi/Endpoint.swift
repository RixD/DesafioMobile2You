//
//  Endpoint.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var method: HTTPMethod { get }
    var params: [String: Any]? { get }
}

extension Endpoint {
    
    var apiKey: String {
        return TmdbConfig.tmdbApiKey
    }
    
    var url: String {
        return "\(baseUrl)/\(path)"
    }
    
    var componetnts: URLComponents? {
        var urlComponents = URLComponents(string: url)
        
        if baseUrl != TmdbConfig.tmdbBaseImageUrl {
            var qyeryItems: [URLQueryItem] = [URLQueryItem(name: "api_key", value: apiKey), URLQueryItem(name: "language", value: LocalizedLanguage.getLanguageCode())]
            
            if let params = params {
                for (key,value) in params {
                    qyeryItems.append(URLQueryItem(name: key, value: "\(value)"))
                }
            }
            qyeryItems = qyeryItems.filter{ !$0.name.isEmpty }
            
            if !qyeryItems.isEmpty {
                urlComponents?.queryItems = qyeryItems
            }
        }
        
        urlComponents?.path = path
        
        return urlComponents
    }
    
    var urlRequest: URLRequest? {
        guard let url = componetnts?.url else { return nil }
        let cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
        let interval: TimeInterval = 20
        
        var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: interval)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        if let headers = headers {
            var headerValues: [String: String] = [:]
            
            for (key, value) in headers {
                headerValues.updateValue(value, forKey: key)
            }
            
            urlRequest.allHTTPHeaderFields = headerValues
        }
        
        
        return urlRequest
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
