//
//  AppDelegate.swift
//  cafe
//
//  Created by Zac on 12/11/16.
//  Copyright © 2016 zeta. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization (options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Should show some kind of alert here; let let user know that they can enable it in settings page if needed.")
            }
        }

        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "5 more sec", options: [])
        let stormOutAction = UNNotificationAction(identifier: "StormOut", title: "Cancel all Orders!", options: [])
        let okayAction = UNNotificationAction(identifier: "Okay", title: "Okay", options: [.destructive])

        let serveLaterCategory = UNNotificationCategory(identifier: CafeNotificationCategory.ServeLater.rawValue, actions: [snoozeAction, okayAction], intentIdentifiers: [], options: [])
        let orderOtherCategory = UNNotificationCategory(identifier: CafeNotificationCategory.SoldOut.rawValue, actions: [stormOutAction, okayAction], intentIdentifiers: [], options: [])

        center.setNotificationCategories([serveLaterCategory, orderOtherCategory])

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate, CafeNotification {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "Snooze" {
            schedule(content: response.notification.request.content, secFromNow: 5)
        }
        completionHandler()
    }
}

