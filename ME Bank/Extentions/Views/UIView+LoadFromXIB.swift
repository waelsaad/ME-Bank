//
//  UIView+LoadFromXIB.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import UIKit

extension UIView {
  @discardableResult
  func loadFromXIB<XIBView: UIView>(named: String? = nil) -> XIBView? {
    let nib = named ?? String(describing: type(of: self))
    guard let view = Bundle.main.loadNibNamed(nib, owner: self, options: nil)?.first as? XIBView else {
      return nil
    }
    
    return view
  }

  func addSubviewFromNib() {
    guard let view = loadViewFromNib() else {
      return
    }

    view.frame = bounds
    view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
    addSubview(view)
  }

  func loadViewFromNib() -> UIView? {
    let nibClass: Swift.AnyClass = type(of: self)

    guard let nibName = nibClass.description().components(separatedBy: ".").last else {
      return nil
    }

    let nib = UINib(nibName: nibName, bundle: Bundle(for: nibClass))
    return nib.instantiate(withOwner: self, options: nil)[0] as? UIView
  }
}
