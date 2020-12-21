//
//  AppDelegate.swift
//  techday
//
//  Created by Lohan Marques on 21/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        start(for: storyboard)
        
        return true
    }
    
    private func start(for storyboard: UIStoryboard) {
        guard let vc = storyboard.instantiateInitialViewController() else { return }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    
    }
}
