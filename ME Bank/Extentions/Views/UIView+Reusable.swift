//
//  UIView+Reusable.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

protocol Reusable {

    static var reuseIdentifier: String { get }
}

extension Reusable {

    static var reuseIdentifier: String { return String(describing: self) }
}
