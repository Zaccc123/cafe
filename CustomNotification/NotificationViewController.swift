//
//  NotificationViewController.swift
//  CustomNotification
//
//  Created by Zac on 24/11/16.
//  Copyright © 2016 zeta. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }

    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "StormOut" {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
        completion(.dismiss)
    }

    func didReceive(_ notification: UNNotification) {
        self.titleLabel.text = notification.request.content.title
        self.bodyLabel?.text = notification.request.content.body
    }

}
