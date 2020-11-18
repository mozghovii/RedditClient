//
//  String.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 19.11.2020.
//

import Foundation

extension String {
    var isHttp: Bool {
        return self.hasPrefix("http")
    }
}
