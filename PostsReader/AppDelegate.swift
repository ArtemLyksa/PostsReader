//
//  AppDelegate.swift
//  PostsReader
//
//  Created by Artem Lyksa on 2/28/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = MainCoordinator(window: window, navigationController: UINavigationController())
        coordinator?.start()
        return true
    }

}

