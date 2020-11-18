//
//  FeedModel.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 18.11.2020.
//

import Foundation

struct FeedModel: Decodable {
    var title: String
    var author: String
    var thumbnail: String?
    var created: Date
    var numComments: Int
}

extension FeedModel {
    var entryDate: String {
        return created.convertToEntryDateString()
    }
    
    var numbersOfComments: String {
        return "\(numComments) comments"
    }
}
