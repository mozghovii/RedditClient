//
//  Storyboard.swift
//  MyBikeValet
//
//  Created by Volodymyr Sakhan on 15.10.2020.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case topFeed = "TopFeed"

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {
        let storyboardIdentifier = (viewControllerClass as UIViewController.Type).storyboardIdentifier
        
        guard let viewController = instance.instantiateViewController(withIdentifier: storyboardIdentifier) as? T else {
            fatalError(
                """
                ViewController with identifier \(storyboardIdentifier), not found in \(self.rawValue) Storyboard.\n
                File: \(file) \n
                Line Number : \(line) \n
                Function : \(function)
                """)
        }
        
        return viewController
    }
    
}
