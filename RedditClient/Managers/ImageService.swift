//
//  ImageDownloader.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 18.11.2020.
//

import UIKit

class ImageService: NSObject {
    
    private let cache = ImageCache()
    
    static let shared: ImageService = {
        let instance = ImageService()
        return instance
    }()
    
    func getImage(by urlString: String, completion: @escaping (UIImage) -> Void) {
        if let image = cache.getOject(key: urlString) as? UIImage {
            completion(image)
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                if let error = error {
                    print(error)
                }  else if let data = data, let image = UIImage(data: data) {
                    let cacheItem = CacheItem(object: image)
                    self?.cache.set(cacheItem, key: urlString)
                    completion(image)
                }
                
            }).resume()
        }
    }
    
}
