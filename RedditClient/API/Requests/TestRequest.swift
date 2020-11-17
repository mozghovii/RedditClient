//
//  TestRequest.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

struct TestRequest: APIRequest {
    
    typealias Response = APIResponseEmpty
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/top.json"
    }
    
}
