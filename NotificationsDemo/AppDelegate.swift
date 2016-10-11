//
//  AppDelegate.swift
//  NotificationsDemo
//
//  Created by Peter Buerer on 9/29/16.
//  Copyright © 2016 Peter Buerer. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //make actions
        let foregroundAction = UNNotificationAction(identifier: "ForeGroundAction", title: "Foreground Title", options: [.foreground])
        let destructiveAction = UNNotificationAction(identifier: "DestructiveAction", title: "Destructive Title", options: [.destructive])
        let authenticationRequiredAction = UNNotificationAction(identifier: "AuthenticationAction", title: "Authentication Required Title", options: [.authenticationRequired])
        let textAction = UNTextInputNotificationAction(identifier: "TextAction", title: "Text Action", options: [], textInputButtonTitle: "Input Button", textInputPlaceholder: "Placeholder")
        
        // types setup categories
        let extensionCategory = UNNotificationCategory(identifier: "ExtensionCategoryIdentifier", actions: [foregroundAction, destructiveAction, authenticationRequiredAction], intentIdentifiers: [], options: .customDismissAction)
        let imageCategory = UNNotificationCategory(identifier: "ImageCategoryIdentifier", actions: [foregroundAction], intentIdentifiers: [], options: .customDismissAction)
        let textInputCategory = UNNotificationCategory(identifier: "TextInputCategoryIdentifier", actions: [textAction], intentIdentifiers: [], options: .customDismissAction)
        let gifCategory = UNNotificationCategory(identifier: "GIFCategoryIdentifier", actions: [foregroundAction], intentIdentifiers: [], options: .customDismissAction)
        
        let vc = ViewController()
        let center = UNUserNotificationCenter.current()
        center.delegate = vc
        center.setNotificationCategories([extensionCategory, imageCategory, textInputCategory, gifCategory])
    
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

