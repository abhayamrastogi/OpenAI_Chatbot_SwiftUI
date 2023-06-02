//
//  APIFetcher.swift
//  ChatGPTSample
//
//  Created by abhayam rastogi on 01/06/23.
//

import Foundation
import Combine

protocol APIFetcherProtocol {
    func fetch<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder) -> AnyPublisher<RequestResponse<T>, Error>
    func fetch<T: Decodable>(_ url: URL, _ method: APIRequestMethod, _ parameter: [String: Any], _ headers: [String: String], _ decoder: JSONDecoder) -> AnyPublisher<RequestResponse<T>, Error>
}

struct APIFetcher: APIFetcherProtocol {
    
    func fetch<T: Decodable>(_ url: URL, _ method: APIRequestMethod, _ parameter: [String: Any], _ headers: [String: String], _ decoder: JSONDecoder) -> AnyPublisher<RequestResponse<T>, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        debugPrint("headers: \(headers)")

        for header in headers { request.addValue(header.value, forHTTPHeaderField: header.key) }
        
        var requestData: Data?
        
        debugPrint("parameters: \(parameter)")
        do {
            requestData = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        } catch {
            return Fail(error: APIError.error("No data found"))
              .eraseToAnyPublisher()
        }
        
        request.httpBody = requestData
        return self.fetch(request, decoder)
    }
    
    func fetch<T>(_ request: URLRequest, _ decoder: JSONDecoder) -> AnyPublisher<RequestResponse<T>, Error> where T : Decodable {
        return URLSession.shared
            .dataTaskPublisher(for: request.debug())
            .tryMap { result -> RequestResponse<T> in
                let json = try JSONSerialization.jsonObject(with: result.data)
                debugPrint(json)
                let value = try decoder.decode(T.self, from: result.data)
                return RequestResponse(value: value, response: result.response)
            }
            .eraseToAnyPublisher()
    }
}

extension URLRequest {
    
    func debug() -> URLRequest {
        debugPrint("**************")

        debugPrint(self.httpMethod)
        
        debugPrint(self.allHTTPHeaderFields)

        debugPrint(self.httpBody)

        debugPrint(self.url)

        debugPrint("**************")
        return self
        
    }
}
