//
//  Notifications.swift
//  NotificationsDemo
//
//  Created by Peter Buerer on 10/8/16.
//  Copyright © 2016 Peter Buerer. All rights reserved.
//

import UserNotifications
import Foundation

extension UNUserNotificationCenter {
    
    
    
    static func postTextNotification(withBodyText text: String) {
        // request authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (successful, error) in
            if !successful {
                print("Notificaiton authorization not successful: \(error?.localizedDescription)")
            }
        }
        
        // build content
        let content = UNMutableNotificationContent()
        content.title = "Text Notification"
        content.subtitle = "Subtitle"
        content.body = text
        
        // set category of notification
        content.categoryIdentifier = "ExtensionCategoryIdentifier"
        
        // create request with trigger and content
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        let request = UNNotificationRequest(identifier: textNotificationIdentifier(), content: content, trigger: nil)
        
        // attempt to schedule
        UNUserNotificationCenter.current().add(request) { (error) in
            guard let error = error else {
                return
            }
            
            print("Error adding request: \(error.localizedDescription)")
        }
    }
    
    static func postImageNotification(handledByExtension useExtension: Bool) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (successful, error) in
            if !successful {
                print("Notificaiton authorization not successful: \(error?.localizedDescription)")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Image Notification"
        content.subtitle = "Image Subtitle"
        content.body = "Image Body"
        
        if useExtension {
            content.categoryIdentifier = "ImageCategoryIdentifier"
        }
        
        guard let url = Bundle.main.url(forResource: "getExcited", withExtension: ".jpg") else {
            print("Couldn't make url for image")
            return
        }
        
        do {
            let imageAttachment = try UNNotificationAttachment(identifier: "ImageAttachment", url: url, options: [:])
            content.attachments = [imageAttachment]
        }
        catch {
            print("Error making attachment")
        }
        
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        let request = UNNotificationRequest(identifier: imageNotificationIdentifier(), content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            guard let error = error else {
                return
            }
            
            print("Error adding request: \(error.localizedDescription)")
        }
    }

    static func postGIFNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (successful, error) in
            if !successful {
                print("Notificaiton authorization not successful: \(error?.localizedDescription)")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "GIF Notification"
        content.subtitle = "GIF Subtitle"
        content.body = "GIF Body"
        content.categoryIdentifier = "GIFCategoryIdentifier"
        
        guard let url = Bundle.main.url(forResource: "dumpsterFire", withExtension: ".gif") else {
            print("Couldn't make url for image")
            return
        }
        
        do {
            let gifAttachment = try UNNotificationAttachment(identifier: "GIFAttachment", url: url, options: [:])
            content.attachments = [gifAttachment]
        }
        catch {
            print("Error making attachment")
        }
        
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        let request = UNNotificationRequest(identifier: imageNotificationIdentifier(), content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            guard let error = error else {
                return
            }
            
            print("Error adding request: \(error.localizedDescription)")
        }
    }
    
    static func postTextInputNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (successful, error) in
            if !successful {
                print("Notification authorization not successful: \(error?.localizedDescription)")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Text Input Notification"
        content.subtitle = "Subtitle"
        content.body = "Text Input Body"
        content.categoryIdentifier = "TextInputCategoryIdentifier"
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        let request = UNNotificationRequest(identifier: textInputNotificationIdentifier(), content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            guard let error = error else {
                return
            }
            
            print("Error adding request: \(error.localizedDescription)")
        }
    }
    
    static func postAudioNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (successful, error) in
            if !successful {
                print("Notificaiton authorization not successful: \(error?.localizedDescription)")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Audio Notification"
        content.subtitle = "Audio Subtitle"
        content.body = "Audio Body"
        
        guard let url = Bundle.main.url(forResource: "CountOfMonteCristo", withExtension: ".mp3") else {
            print("Couldn't make url for image")
            return
        }
        
        do {
            let audioAttachment = try UNNotificationAttachment(identifier: "AudioAttachment", url: url, options: [:])
            content.attachments = [audioAttachment]
        }
        catch {
            print("Error making attachment")
        }
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        let request = UNNotificationRequest(identifier: audioNotificationIdentifier(), content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            guard let error = error else {
                return
            }
            
            print("Error adding request: \(error.localizedDescription)")
        }
    }
    
    
    static func textNotificationIdentifier() -> String {
        return "TextNotificationIdentifier"
    }
    
    static func textInputNotificationIdentifier() -> String {
        return "TextInputNotificationIdentifier"
    }
    
    static func imageNotificationIdentifier() -> String {
        return "ImageNotificationIdentifier"
    }
    
    static func gifNotificationIdentifier() -> String {
        return "GIFNotificationIdentifier"
    }
    
    static func audioNotificationIdentifier() -> String {
        return "audioNotificationIdentifier"
    }
    
    static func postNotification(forType type: NotificationType) {
        switch type {
        case .text:
            UNUserNotificationCenter.postTextNotification(withBodyText: "Text Body Text")
        case .image:
            UNUserNotificationCenter.postImageNotification(handledByExtension: true)
        case .textInput:
            UNUserNotificationCenter.postTextInputNotification()
        case .gif:
            UNUserNotificationCenter.postGIFNotification()
        case .audio:
            UNUserNotificationCenter.postAudioNotification()
        }
    }
}
