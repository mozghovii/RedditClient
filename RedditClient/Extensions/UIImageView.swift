//
//  UIImageView.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 18.11.2020.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func setImage(by url: String)  {
        image = nil
        ImageService.shared.getImage(by: url) { (image) in
            DispatchQueue.main.async { [weak self] in
            self?.image = image
            }
        }
    }
}
