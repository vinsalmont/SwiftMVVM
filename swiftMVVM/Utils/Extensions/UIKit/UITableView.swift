//
//  UITableView.swift
//  swiftMVVM
//
//  Created by Vinícius Salmont
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import UIKit

public extension UITableView {
    /** Shortcut: Register a cell with his Default name and identifier on the main bundle. */
    func registerCell<T: UITableViewCell>(cellClass: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.defaultIdentifier)
    }
    
    /** Shortcut: Dequeue a cell with his default Class Name. Example: MyCustomCell.self */
    func dequeue<T: UITableViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        return self.dequeue(withIdentifier: cellClass.defaultIdentifier, indexPath: indexPath)
    }
    
    // swiftlint:disable force_cast
    /** Dequeue a cell with automatic casting */
    private func dequeue<T: UITableViewCell>(withIdentifier id: String, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: id, for: indexPath) as! T
    }
    // swiftlint:enable force_cast
}
