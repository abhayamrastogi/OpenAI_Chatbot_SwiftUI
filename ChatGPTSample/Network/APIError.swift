//
//  APIError.swift
//  ChatGPTSample
//
//  Created by abhayam rastogi on 02/06/23.
//

import Foundation

enum APIError: Error {
    case error(String)
    
    var description: String {
        switch self {
        case .error(let msg):
            return msg
        }
    }
}
