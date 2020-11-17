//
//  JSONDecoder.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

extension JSONDecoder {
    
    static func apiJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        // date decode
        decoder.dateDecodingStrategy = .secondsSince1970
        // from snake case
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }
    
    func decode<T: Decodable>(from data: Data?) -> T? {
        guard let data = data else {
            return nil
        }
        
        return try? self.decode(T.self, from: data)
    }
    
}
