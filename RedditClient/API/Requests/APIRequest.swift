//
//  APIRequest.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var path: String { get }
    var method: HTTPMethod { get }
    var parameterEncoding: ParameterEncoding { get }
    func parameters() -> Any?
    
}

// MARK: - Defaults

extension APIRequest {
    
    var jsonEncoder: JSONEncoder {
        return JSONEncoder.apiJSONEncoder()
    }
    
    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding()
        default:
            // TODO - for others methods.
            return URLEncoding()
        }
    }
    
    func prepareParameters<T>(_ parameters: T) -> Any? where T: Encodable {
        guard let data = try? jsonEncoder.encode(parameters) else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
    }
    
    func parameters() -> Any? {
        return prepareParameters(self)
    }
    
}
