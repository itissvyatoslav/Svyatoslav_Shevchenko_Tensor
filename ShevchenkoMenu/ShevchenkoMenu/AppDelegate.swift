//
//  AppDelegate.swift
//  ShevchenkoMenu
//
//  Created by user on 22/11/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        loadData()
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if error != nil{
                print("Authorization unsuccessful")
            } else {
                print("Authorization successful")
            }
        }

        print("didFinishLaunchingWithOptions")
        return true
    }

}
