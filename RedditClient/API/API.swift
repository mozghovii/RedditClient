//
//  API.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

protocol API: AnyObject {
    init(with configuration: APIConfiguration)
    func setEnvironment(_ environment: APIEnvironment)
    func send<T>(_ request: T, completion: @escaping ResultCallback<T.Response>) where T: APIRequest
}
