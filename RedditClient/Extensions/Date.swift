//
//  Date.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 18.11.2020.
//

import Foundation

extension Date {
    
    func convertToEntryDateString() -> String {
        let timeFormatter = RelativeDateTimeFormatter()
        timeFormatter.unitsStyle = .full
        return timeFormatter.localizedString(for: self, relativeTo: Date())
    }
    
}
