//
//  CafeNotification.swift
//  cafe
//
//  Created by Zac on 17/11/16.
//  Copyright © 2016 zeta. All rights reserved.
//

import Foundation
import UserNotifications

enum CafeNotificationCategory: String {
    case ServeLater = "ReminderCategory"
    case SoldOut = "OrderOtherItemCategory"
}

protocol CafeNotification {
    
    func schedule(content: UNNotificationContent, secFromNow: TimeInterval)
    func createNotificationContent(title: String, text: String, attachment: String?, category: CafeNotificationCategory?) -> UNNotificationContent
}

extension CafeNotification {
    private func setAttachmentForNotification(content: UNMutableNotificationContent, attachment: String) {
        let attachments = attachment.components(separatedBy: ".")

        if let path = Bundle.main.path(forResource: attachments.first, ofType: attachments.last) {
            let url = URL(fileURLWithPath: path)

            do {
                let attachment = try UNNotificationAttachment(identifier: attachment, url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
    }

    func createNotificationContent(title: String, text: String, attachment: String? = nil, category: CafeNotificationCategory? = nil) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = text
        content.sound = UNNotificationSound.default()

        if let attachment = attachment {
            setAttachmentForNotification(content: content, attachment: attachment)
        }

        if let category = category {
            content.categoryIdentifier = category.rawValue
        }
        
        return content
    }

    func schedule(content: UNNotificationContent, secFromNow: TimeInterval) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: secFromNow, repeats: false)
        let request = UNNotificationRequest(identifier: content.title, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
