//
//  Theme.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import UIKit.UIColor

struct Theme {
    struct Font {}
    struct Color {}
    struct Paragraph {}
    struct StringAttributes {}
    struct Buttons {}
}

extension UIColor {
    private static func colorFrom(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    static let lightBlue: UIColor = UIColor.colorFrom(red: 43, green: 132, blue: 210, alpha: 1)
    static let navBarColor: UIColor = UIColor.colorFrom(red: 52 / 255, green: 152 / 255, blue: 219 / 255, alpha: 1)
}

extension Theme.Color {
    static let labelBorderColor: UIColor = .lightBlue
}

