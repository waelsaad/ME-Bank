//
//  UIView+Nib.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import UIKit

/// Consolidate view loading from nibs under a single protocol
protocol ViewWithNib {

    static var nibName: String { get }
}

extension ViewWithNib {

    static var nibName: String { return String(describing: `self`) }
}

extension ViewWithNib where Self: UIView {

    static func nib(bundle: Bundle = .main) -> UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }

    static func loadFromNib(bundle: Bundle = .main, owner: Any? = nil, options: [AnyHashable: Any]? = nil, frame: CGRect? = nil) -> Self {
        for case let view as Self in nib(bundle: bundle).instantiate(withOwner: owner, options: options as? [UINib.OptionsKey : Any]) {
            if let frame = frame { view.frame = frame }
            return view
        }

        fatalError("No object of class \(Self.self) in nib (named: \(nibName), bundle: \(String(describing: bundle)))")
    }

    func addSubviewFromNib(bundle: Bundle = .main, options: [AnyHashable: Any]? = nil) {
      // swiftlint:disable line_length
        guard let view = Self.nib(bundle: bundle).instantiate(withOwner: self, options: options as? [UINib.OptionsKey : Any]).first as? UIView else {
            return
        }

        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
}


