//
//  RotationViewTests.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import XCTest
import UIKit
@testable import ME_Bank

class RotationViewTests: XCTestCase {

    var rotationView: RotatedView!
    override func setUp() {
        
        rotationView = RotatedView()
    }

    func testCreateRotationView() {
        XCTAssertNotNil(rotationView)
    }
    
    func testAddBackView() {
        XCTAssertNil(rotationView.backView)
        let color = UIColor.red
        rotationView.addBackView(100, color: color)
        
        XCTAssertNotNil(rotationView.backView)
        XCTAssertEqual(rotationView.backView?.backgroundColor, color)
    }
    
    func testRotateX() {
        let key = "layer.transform.rotation.x"
        let startX = (rotationView.value(forKeyPath: key) as? NSNumber)?.floatValue
        XCTAssertEqual(startX, 0)

        let angel: CGFloat = 0.5
        rotationView.rotatedX(angel)
        let x = (rotationView.value(forKeyPath: key) as? NSNumber)?.floatValue

        XCTAssertEqual(x, Float(angel))
    }
}
