//
//  Environment.swift
//  TestswiftMVVMApp
//
//  Created by Vinícius Salmont
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import Foundation

extension Environment {
    enum Variable: String {
        case appName = "APP_NAME"
        case appBundleID = "APP_BUNDLE_ID"
        case appCenterKey = "APP_CENTER_KEY"
        case parseAppId = "PARSE_APP_ID"
        case parseURL = "PARSE_URL"
    }
}

struct Environment {
    static func getValue(forKey key: Variable) -> String {
        return infoForKey(key.rawValue)
    }
    
    private static func infoForKey(_ key: String) -> String {
        guard let value = (Bundle.main.infoDictionary?[key] as? String) else {
            fatalError("Could not get value for key: \(key)")
        }
        return value.replacingOccurrences(of: "\\", with: "")
    }
}
