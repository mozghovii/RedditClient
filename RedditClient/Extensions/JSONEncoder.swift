//
//  JSONEncoder.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

extension JSONEncoder {
    
    static func apiJSONEncoder() -> JSONEncoder {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .init(rawValue: 0)
        jsonEncoder.dateEncodingStrategy = .secondsSince1970
        jsonEncoder.keyEncodingStrategy = .useDefaultKeys
        return jsonEncoder
    }
    
    func encode<T: Encodable>(from value: T?) -> Data? {
        guard let value = value else {
            return nil
        }
        
        return try? self.encode(value)
    }
    
}
