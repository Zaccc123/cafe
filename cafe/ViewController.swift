//
//  ViewController.swift
//  cafe
//
//  Created by Zac on 12/11/16.
//  Copyright © 2016 zeta. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, CafeNotification {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - User Interactions
    @IBAction func coffeeOrderButtonPressed(_ sender: UIButton) {
        let content = createNotificationContent(title: "Flat White", text: "Your freshly brew flat white is ready!")
        schedule(content: content, secFromNow: 3)
    }

    @IBAction func pastaOrderButtonPressed(_ sender: UIButton) {
        let content = createNotificationContent(title: "Tomato Pasta", text: "Your pasta is ready. We will be serving to you shortly!", attachment: "tomato_pasta.jpg")
        schedule(content: content, secFromNow: 5)
    }

    @IBAction func steakOrderButtonPressed(_ sender: UIButton) {
        let content = createNotificationContent(title: "Steak", text: "Sorry, we run out of steak. Would you like to order something else?", category: .SoldOut)
        schedule(content: content, secFromNow: 7)
    }

    @IBAction func dessertOrderButtonPressed(_ sender: UIButton) {
        let content = createNotificationContent(title: "Cheesecake Truffles", text: "Should we serve your dessert now?", attachment: "truffles.gif", category: .ServeLater)
        schedule(content: content, secFromNow: 7)
    }
}

