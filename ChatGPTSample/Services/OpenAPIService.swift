//
//  OpenAPIService.swift
//  ChatGPTSample
//
//  Created by abhayam rastogi on 01/06/23.
//

import Foundation
import Combine

protocol OpenAIService {
    func sendMessage(_ role: String, content:String) ->  AnyPublisher<RequestResponse<OpenAIModel>, Error>
}

final class ConcreteOpenAIService: ApiModel, OpenAIService {
        
    func sendMessage(_ role: String, content:String) -> AnyPublisher<RequestResponse<OpenAIModel>, Error> {
        guard let chatURL = APIURLData.chat.url else { fatalError("URL not found")}
        let messages = [
            ["role": role, "content": content]
        ]
        
        let httpBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages
        ]
        return self.apiFetcher.fetch(chatURL, .POST, httpBody, self.headers, JSONDecoder())
    }
    
    
}
