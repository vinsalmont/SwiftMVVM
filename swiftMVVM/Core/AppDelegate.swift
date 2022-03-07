//
//  AppDelegate.swift
//  swiftMVVM
//
//  Created by Vinícius Salmont
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupSettings()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        self.appCoordinator = AppCoordinator(window: window!)
        self.appCoordinator.start()
        
        return true
    }

    /**
     * Update settings values so they're available in the iOS Settings app
     */
    private func setupSettings() {
        // Show application version and build in settings
        let appInfo = Bundle.main.infoDictionary ?? [:]
        let shortVersionString = appInfo["CFBundleShortVersionString"] as? String ?? ""
        let bundleVersion = appInfo["CFBundleVersion"] as? String ?? ""
        
        let defaults = UserDefaults.standard
        defaults.set(shortVersionString, forKey: "application_version")
        defaults.set(bundleVersion, forKey: "application_build")
    }
}
