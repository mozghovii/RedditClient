//
//  TopFeedViewModelItem.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 18.11.2020.
//

import Foundation

protocol ViewModelItem: class {
    var headerTitle: String? { get }
    var rowCount: Int { get }
}

extension ViewModelItem {
    
    var headerTitle: String? {
        return nil
    }
    
    var rowCount: Int {
        return 0
    }
    
}

class TopFeedViewModelItem: ViewModelItem {
    var headerTitle: String? {
        return nil
    }
    
    var rowCount: Int {
        return models.count
    }
    
    var models: [FeedDataModel]
    
    init(_ models:[FeedDataModel]) {
        self.models = models
    }
    
    func appendModels(_ models: [FeedDataModel]) {
        self.models.append(contentsOf: models)
    }
}
