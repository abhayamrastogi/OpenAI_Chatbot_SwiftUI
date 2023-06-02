//
//  APIModel.swift
//  ChatGPTSample
//
//  Created by abhayam rastogi on 01/06/23.
//

import Foundation

class ApiModel: ObservableObject {
 
    private let openAIKey = "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"

    enum Headers: String {
        case contentType = "Content-Type"
        case authorization = "Authorization"
    }
    
    private(set) lazy var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }()

    private(set) lazy var jsonEncoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        return jsonEncoder
    }()
    
    var headers: [String: String] {
        [Headers.contentType.rawValue: "application/json",
         Headers.authorization.rawValue: "Bearer \(self.openAIKey)"
        ]
    }
    
    var apiFetcher: APIFetcher {
        APIFetcher()
    }
    
}
