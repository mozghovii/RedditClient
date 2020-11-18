//
//  CacheItem.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 18.11.2020.
//

import Foundation

class CacheItem: NSDiscardableContent {
    
    var object: AnyObject?
    
    private var accessCount: UInt = 0
    
    init(object: AnyObject) {
        self.object = object
    }
    
    public func beginContentAccess() -> Bool {
        if object == nil {
            return false
        }
        
        accessCount += 1
        return true
    }
    
    public func endContentAccess() {
        if accessCount > 0 {
            accessCount -= 1
        }
    }
    
    public func discardContentIfPossible() {
        if accessCount == 0 {
            object = nil
        }
    }
    
    public func isContentDiscarded() -> Bool {
        return object == nil
    }
}
