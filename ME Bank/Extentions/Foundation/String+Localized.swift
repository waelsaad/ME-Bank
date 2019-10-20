//
//  String+Localized.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: .empty)
  }

  func localizedWithFormat(args: CVarArg...) -> String {
    return String(format: localized, locale: NSLocale.current, arguments: args)
  }
}

extension String {
  func deletingPrefix(_ prefix: String) -> String {
    guard self.hasPrefix(prefix) else { return self }
    return String(self.dropFirst(prefix.count))
  }
}
