//
//  DataModel.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 18.11.2020.
//

import Foundation

struct DataModel: Decodable {
    var after: String?
    var before: String?
    let children: [FeedDataModel]
}
