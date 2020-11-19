//
//  GetTopFeedRequest.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 18.11.2020.
//

import Foundation

struct GetTopFeedRequest: APIRequest {
    
    typealias Response = GetTopFeedResponse
    private(set) var after: String?
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/top.json"
    }
    
    init(by after: String?) {
        self.after = after
    }

}
