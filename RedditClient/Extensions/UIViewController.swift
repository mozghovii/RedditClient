//
//  UIViewController.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import UIKit

extension UIViewController {
    
    class var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func instantiate(fromStoryboardType storyboard: Storyboard) -> Self {
        let instance = storyboard.viewController(viewControllerClass: self)
        return instance
    }
    
}

extension UIViewController: Presentable {
    
    func toPresentable() -> UIViewController {
        return self
    }
    
}
