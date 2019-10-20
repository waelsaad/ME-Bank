//
//  UITableView+CellRegistration.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
//    func register(forClass aClass: AnyClass) {
//        let className = String(describing: aClass)
//        register(UINib(nibName: className, bundle: Bundle.main), forCellReuseIdentifier: className)
//    }
//
//    func register(forClass aClass: AnyClass, nibName: String) {
//        let className = String(describing: aClass)
//        register(UINib(nibName: nibName, bundle: Bundle.main), forCellReuseIdentifier: className)
//    }
//
//    func dequeueReusableCell<T: UITableViewCell>(forClass aClass: AnyClass) -> T {
//        let className = String(describing: aClass)
//
//        guard let cell = dequeueReusableCell(withIdentifier: className) as? T else {
//            fatalError("Cannot deque cell for class \(aClass)")
//        }
//
//        return cell
//    }
    
    
    
    
    func registerCells(_ cellClasses: [AnyClass]) {
        cellClasses.forEach(registerCell)
    }
    
    func registerCell(_ cellClass: AnyClass) {
        let className: String = String(describing: cellClass)
        register(UINib(nibName: className, bundle: Bundle.main), forCellReuseIdentifier: className)
    }
    
    func registerHeaderFooter(_ viewClass: AnyClass) {
        let className: String = String(describing: viewClass)
        register(UINib(nibName: className, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        let className: String = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            fatalError("Cannot dequeue cell for class \(className)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        let className: String = String(describing: T.self)
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: className) as? T else {
            fatalError("Cannot dequeue header footer view for class \(className)")
        }
        return view
    }
    
    func dequeueReusableCell<T>(withClass: T.Type) -> T where T: UITableViewCell, T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T ?? T()
    }
}

