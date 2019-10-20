//
//  Result.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

struct Employees: Codable {
    let users: [User]?
    var info: info
    
    enum CodingKeys: String, CodingKey {
        case users = "results"
        case info
    }
}

struct info: Codable {
    private(set) var results: Int
    private(set) var page: Int
}
