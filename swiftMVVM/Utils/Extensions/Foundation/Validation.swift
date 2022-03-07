//
//  Validation.swift
//  swiftMVVM
//
//  Created by Vinícius Salmont
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import Foundation

enum ValidationType {
    case email, password, custom(String)
    
    var pattern: String {
        switch self {
        case .password:
            return "((?=.*[A-Za-z])(?=.*[A-Z])(?=.*[a-z]))^.{8,}"
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case .custom(let pattern):
            return pattern
        }
    }
}

// MARK: Validation
extension String {
    
    func isValid(as validationType: ValidationType) -> Bool {
        self.matchRegex(self, regex: validationType.pattern)
    }
    
    private func matchRegex(_ string: String, regex: String) -> Bool {
        let test = NSPredicate(format: "%@ MATCHES %@", string, regex)
        return test.evaluate(with: self)
    }
    
}
