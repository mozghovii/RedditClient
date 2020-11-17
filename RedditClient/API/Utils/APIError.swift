//
//  APIError.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

enum APIError: Error {
    case somethingWentWrong
}

// MARK: - Helpers

extension APIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .somethingWentWrong:
            return "Oops! Looks like an error has occurred on our end. Please try again later."
        }
    }
}
