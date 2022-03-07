//
//  UIColor+Additions.swift
//  swiftMVVM
//
//  Created by Vinícius Salmont
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// HEX: #EB5757
    @nonobjc class var redError: UIColor {
        UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
    }

    static func typeColor(type: String) -> UIColor {
        if type.lowercased().contains("spell") {
            return .systemTeal
        } else if type.lowercased().contains("skill") {
            return .systemTeal
        } else if type.lowercased().contains("monster") {
            return .brown
        } else if type.lowercased().contains("trap") {
            return .systemPink
        } else {
            return .blue
        }
    }
}
