//
//  TmdbError.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import Foundation

class TmdbError: NSObject, Codable {
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?

    init(statusMessage: String) {
        self.statusCode = 0
        self.statusMessage = statusMessage
        self.success = false
        super.init()
    }

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(statusCode, forKey: .statusCode)
        try container.encode(statusMessage, forKey: .statusMessage)
        try container.encode(success, forKey: .success)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statusCode = try? container.decode(Int.self, forKey: .statusCode)
        self.statusMessage = try? container.decode(String.self, forKey: .statusMessage)
        self.success = try? container.decode(Bool.self, forKey: .success)
    }

    static var defaultModel: TmdbError {
        return TmdbError(statusMessage: "Connection error")
    }
    
    static var FailedRequest: TmdbError {
        return TmdbError(statusMessage: "Resquest failed. Please, try again later.")
    }
    
    static var ServerError: TmdbError {
        return TmdbError(statusMessage: "Server Error. Please, try again later.")
    }
    
    static var Unauthorized: TmdbError {
        return TmdbError(statusMessage: "Unauthorized request.")
    }
    
    static var NotFound: TmdbError {
        return TmdbError(statusMessage: "Bad request error.")
    }
}
