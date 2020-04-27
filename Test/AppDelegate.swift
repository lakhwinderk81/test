//
//  AppDelegate.swift
//  Test
//
//  Created by apple on 19/04/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    //MARK: - Singleton -
    class func sharedAppDelegate()->AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setLocalAccount()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//Setting some local accounts
extension AppDelegate{
    func setLocalAccount() {
        var account: [[String: Any]] = []
        account.append(["email": "user1@gmail.com", "password": "12345"])
        account.append(["email": "user2@gmail.in", "password": "qwerty"])
        account.append(["email": "user3@yopmail.in", "password": "abc123"])
        UserDefaults.standard.set(account, forKey: "Accounts")
    }
}
