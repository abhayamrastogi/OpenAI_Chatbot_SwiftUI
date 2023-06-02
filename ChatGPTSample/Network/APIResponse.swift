//
//  APIResponse.swift
//  ChatGPTSample
//
//  Created by abhayam rastogi on 01/06/23.
//

import Foundation

struct RequestResponse<T> {
    let value: T
    let response: URLResponse
}
