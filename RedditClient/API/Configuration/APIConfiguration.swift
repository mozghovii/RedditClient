//
//  APIConfiguration.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

protocol APIConfiguration: AnyObject {
    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }
    var defaultURLSessionConfiguration: URLSessionConfiguration { get }
    func getBaseEndpointURL(environment: APIEnvironment) -> URL
}
