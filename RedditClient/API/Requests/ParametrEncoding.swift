//
//  ParametrEncoding.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest
}
