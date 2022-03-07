//
//  UITableViewCell.swift
//  swiftMVVM
//
//  Created by Vinícius Salmont
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    
    /** Return identifier with the same name of the subclass */
    static var defaultIdentifier: String {
        return String(describing: self)
    }
}
