//
//  AppDelegate.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 24/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window: UIWindow! = UIWindow(frame: UIScreen.main.bounds)
    let coordinator = ShoppingFlowCoordinator()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setGlobalNavigationBarAppearance()
        window.rootViewController = coordinator.navigationViewController
        window.makeKeyAndVisible()
        return true
    }

    func setGlobalNavigationBarAppearance() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor(red:0/255, green:128/255, blue:0/255, alpha:1.0)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .white
    }

}

