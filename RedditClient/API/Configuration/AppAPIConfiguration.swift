//
//  AppAPIConfiguration.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

class AppAPIConfiguration: APIConfiguration {
        
    var decoder: JSONDecoder {
        return JSONDecoder.apiJSONDecoder()
    }
    
    var encoder: JSONEncoder {
        return JSONEncoder.apiJSONEncoder()
    }
    
    var defaultURLSessionConfiguration: URLSessionConfiguration {
        return URLSessionConfiguration.default
    }
    
    func getBaseEndpointURL(environment: APIEnvironment) -> URL {
        if case .staging = environment {
            return GlobalConsts.API.baseEndpointURL
        } else {
            return GlobalConsts.API.baseEndpointProductionURL
        }
    }
    
}
