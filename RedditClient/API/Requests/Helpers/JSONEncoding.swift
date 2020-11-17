//
//  JSONEncoding.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

public struct URLEncoding: ParameterEncoding {
    public func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        var preparedRequest = urlRequest
        
        guard let parameters = parameters else { return urlRequest }
        
        if let method = preparedRequest.httpMethod, method == HTTPMethod.get.rawValue {
            guard let url = urlRequest.url else {
                throw APIError.somethingWentWrong
            }
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                preparedRequest.url = urlComponents.url
            }
            
        } else {
            // TODO: If you need others methods you will be able to implement. You should fill httpBody
        }
        
        return urlRequest
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        return parameters.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}
