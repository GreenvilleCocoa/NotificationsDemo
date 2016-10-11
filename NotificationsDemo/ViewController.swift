//
//  ViewController.swift
//  NotificationsDemo
//
//  Created by Peter Buerer on 9/29/16.
//  Copyright © 2016 Peter Buerer. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate, UITableViewDelegate, UITableViewDataSource {

    let dataSource = NotificationOptionsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        let views = [ "table": tableView ]
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[table]|", options: [], metrics: [:], views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[table]|", options: [], metrics: [:], views: views))
    }

    
    // MARK: - UNUserNotificationCenterDelegate
    
    // user acted on notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // process user actions taken with notification
        if response.actionIdentifier == "TextAction" {
            let text = (response as! UNTextInputNotificationResponse).userText
            print("User text: \(text)")
        }
        
        completionHandler()
    }
    
    // notification delivered to foreground app
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // show the notification when app is in foreground
        completionHandler(.alert)
        //use when you don't want to show the notification while the app is in the foreground
//        completionHandler(UNNotificationPresentationOptions(rawValue: 0))
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.options[indexPath.row]
        UNUserNotificationCenter.postNotification(forType: item.type)
    }
    
    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        let item = dataSource.options[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    // MARK: - Views
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        return table
    }()
    
}

