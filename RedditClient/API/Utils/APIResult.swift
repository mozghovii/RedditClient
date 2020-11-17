//
//  APIResult.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

enum APIResult<Value> {
    case success(Value)
    case failure(Error)
}

typealias ResultCallback<Value> = (APIResult<Value>) -> Void
