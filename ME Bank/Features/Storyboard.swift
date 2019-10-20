//
//  Storyboard.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

enum Storyboard: String {
    case employeeList
}

extension Storyboard {
    var filename: String {
        let name = rawValue
        guard let first = name.first else { return "" }
        return String(first).uppercased() + name.dropFirst()
    }
}

