//
//  Date.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 18.11.2020.
//

import Foundation

extension Date {
    
    static private let timeFormatter: RelativeDateTimeFormatter = {
        let timeFormatter = RelativeDateTimeFormatter()
        timeFormatter.unitsStyle = .full
        return timeFormatter
    }()
    
    func convertToEntryDateString() -> String {
        return Self.timeFormatter.localizedString(for: self, relativeTo: Date())
    }
    
}
