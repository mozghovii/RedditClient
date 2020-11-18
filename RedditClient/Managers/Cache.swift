//
//  Cache.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 18.11.2020.
//

import Foundation

protocol Cache: AnyObject {
    func set<T>(_ object: T, key: String) where T: CacheItem
    func getOject(key: String) -> AnyObject?
}
