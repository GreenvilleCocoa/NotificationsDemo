//
//  NotificationOptionsDataSource.swift
//  NotificationsDemo
//
//  Created by Peter Buerer on 10/9/16.
//  Copyright © 2016 Peter Buerer. All rights reserved.
//

import Foundation

enum NotificationType {
    case text
    case image
    case textInput
    case gif
    case audio
}

struct OptionItem {
    let type: NotificationType
    let title: String
}

class NotificationOptionsDataSource {
    
    let options: [OptionItem]
    
    init() {
        options = [
                   OptionItem(type: .text, title: "All Text"),
                   OptionItem(type: .image, title: "Static Image"),
                   OptionItem(type: .textInput, title: "Text Input"),
                   OptionItem(type: .gif, title: "Gif"),
                   OptionItem(type: .audio, title: "Audio"),
        ]
    }
}
