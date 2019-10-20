//
//  Name.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

struct Name: Codable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
    }
    
    init(name: String, lastName: String){
        self.firstName = name
        self.lastName = lastName
    }
}

extension Name {
    var fullName: String {
        return firstName.capitalized + " " + lastName.capitalized
    }
}
