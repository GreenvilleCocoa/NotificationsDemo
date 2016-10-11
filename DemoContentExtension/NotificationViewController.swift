//
//  NotificationViewController.swift
//  DemoContentExtension
//
//  Created by Peter Buerer on 10/8/16.
//  Copyright © 2016 Peter Buerer. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

// Apparently the @objc decoration is needed for the extension to be able to use this as the NSExtensionPrincipalClass
// https://stackoverflow.com/questions/24416003/writing-an-ios-8-share-extension-without-a-storyboard
@objc(NotificationViewController)
class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    // MARK: - Initialization
    
    // Used when not using storyboard
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        preferredContentSize = CGSize(width: 128.0, height: 128.0)
    }
    
    // Used when using a storyboard
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(imageView)
        
        let views: [String : Any] = [ "label": label, "image": imageView, ]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]|", options: [], metrics: nil, views: views))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[image]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image]|", options: [], metrics: nil, views: views))
    }
    
    // notification arrived - do view setup etc
    func didReceive(_ notification: UNNotification) {
        let identifier = notification.request.identifier
        
        // process image notifications
        if identifier == UNUserNotificationCenter.imageNotificationIdentifier() {
            guard let attachment = notification.request.content.attachments.first else {
                return
            }
            
            // access scoped url
            if attachment.url.startAccessingSecurityScopedResource() {
                guard let url = notification.request.content.attachments.first?.url else {
                    return
                }
                do {
                    let data = try Data(contentsOf: url)
                    imageView.image = UIImage(data: data)
                }
                catch {
                    print("Couldn't make image")
                    return
                }
                
                attachment.url.stopAccessingSecurityScopedResource()
            }
        }
        else {
            label.text = "Extension Text"
        }
    }
    
    // choose what to do with user actions
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        // handle actions
        if response.actionIdentifier == "ForeGroundAction" {
            label.text = "Action Received"
            completion(.doNotDismiss)
//            completion(.dismiss)
        }
        else {
            completion(.dismissAndForwardAction)
        }
    }
    
    // MARK: - Views
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
}
