//
//  APIURLData.swift
//  ChatGPTSample
//
//  Created by abhayam rastogi on 02/06/23.
//

import Foundation

enum APIURLData {
    case chat
    
    var path: String {
        switch self {
        case .chat:
            return "/v1/chat/completions?="
        }
    }
    
    private var urlString: String {
        EnvironmentManager.openAIURL + self.path
    }
    
    var url: URL? {
        URL(string: self.urlString)
    }
}
