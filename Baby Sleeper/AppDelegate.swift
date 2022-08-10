//
//  AppDelegate.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/29/22.
//

import UIKit
import GoogleMobileAds
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var timerAdd : Timer = Timer()
    var timerAddCount = 10

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        timerAdd = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addCounterr), userInfo: nil, repeats: true)
        // Override point for customization after application launch.
        return true
    }
    @objc func addCounterr(){
        Utils.addTimer -= 1
        if Utils.addTimer == 0 {
            Utils.addShow = true
          
        }
        print(Utils.addTimer)
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

