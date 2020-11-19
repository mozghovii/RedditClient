//
//  ImageCache.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 18.11.2020.
//

import Foundation
import UIKit

final class ImageCache: Cache {
    private let imageCache = NSCache<NSString, CacheItem>()

    func set<T>(_ object: T, key: String) where T : CacheItem {
        imageCache.setObject(object, forKey:key as NSString)

    }
    
    func getOject(key: String) -> AnyObject? {
        if let image = imageCache.object(forKey: key as NSString)?.object as? UIImage {
            return image
        }
        return nil
    }
}
