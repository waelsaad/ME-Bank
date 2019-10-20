//
//  Decodable+Json.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

extension Decodable {
    
    static func parse(jsonFile: String) -> Self? {
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: FileTypes.json.rawValue),
            let data = try? Data(contentsOf: url),
            let output = try? JSONDecoder().decode(self, from: data)
            else {
                return nil
        }
        
        return output
    }
    
//    static func decodeJson<T>(forResource: String, toType: T.Type) -> T? where T : Decodable {
//        let url = Bundle.main.url(forResource: forResource, withExtension: "json")
//        let data = try? Data(contentsOf: url!)
//        let result = try? JSONDecoder().decode(toType, from: data!)
//        assert(result != nil, "Failed to parse JSON for resource \"\(forResource).json\" to type \(toType)")
//        return result
//    }
}
