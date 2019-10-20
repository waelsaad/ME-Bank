//
//  User.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: Name
    let dob: BirthDay?
    let gender: Gender
    let picture: Picture?

    init(name: Name,
         dob: BirthDay?,
         gender: Gender,
         picture: Picture?) {
        self.name = name
        self.dob = dob
        self.gender = gender
        self.picture = picture
    }
}

enum Gender: String, Codable {
    case female
    case male
}

struct BirthDay: Codable {
    let date: String?
    let age: Int?
}

extension User {
    var dateOfBirth: String {
        return dob?.date?.formatedDate ?? String.empty
    }
}
