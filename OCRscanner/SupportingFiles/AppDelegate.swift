//
//  AppDelegate.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let controller = ViewController()
        controller.view.backgroundColor = .red
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        return true
    }
}

