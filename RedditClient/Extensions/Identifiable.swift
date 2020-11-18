//
//  Identifiable.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation
import UIKit

protocol Identifiable: class {
    
    static var identifier: String { get }
    static var nib: UINib { get }
    
}

extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
