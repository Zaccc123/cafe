//
//  ViewController.swift
//  cafe
//
//  Created by Zac on 12/11/16.
//  Copyright © 2016 zeta. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Notifcations Helpers
    func setAttachmentForNotification(content: UNMutableNotificationContent, attachment: String) {
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

    func createNotificationContent(title: String, text: String, attachment: String?, action: Bool = false) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = text
        content.sound = UNNotificationSound.default()
        if let attachment = attachment {
            setAttachmentForNotification(content: content, attachment: attachment)
        }

        if action {
            content.categoryIdentifier = "ReminderCategory"
        }

        return content
    }

    func scheduleNotifcation(content: UNNotificationContent, timeInterval: Double) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)

        let request = UNNotificationRequest(identifier: content.title, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }

    //MARK: - User Interactions
    @IBAction func coffeeOrderButtonPressed(_ sender: UIButton) {
        let content = createNotificationContent(title: "Flat White", text: "Your freshly brew flat white is ready!", attachment: nil)
        scheduleNotifcation(content: content, timeInterval: 3)
    }

    @IBAction func pastaOrderButtonPressed(_ sender: UIButton) {
        let content = createNotificationContent(title: "Tomato Pasta", text: "Your pasta is ready. We will be serving to you shortly!", attachment: "tomato_pasta.jpg")
        scheduleNotifcation(content: content, timeInterval: 5)
    }

    @IBAction func dessertOrderButtonPressed(_ sender: UIButton) {
        let content = createNotificationContent(title: "Cheesecake Truffles", text: "Should we serve your dessert now?", attachment: "truffles.gif", action: true)
        scheduleNotifcation(content: content, timeInterval: 7)
    }
}

