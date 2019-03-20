//
//  AppDelegate.swift
//  Starface
//
//  Created by Aleksander Lorenc on 29/09/2018.
//  Copyright © 2018 Aleksander Lorenc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var window: UIWindow?
    private var appCoordinator: AppCoordinator!

    func applicationDidFinishLaunching(_ application: UIApplication) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()

        self.appCoordinator = AppCoordinator(window: self.window)
        self.appCoordinator.start()
    }
}
