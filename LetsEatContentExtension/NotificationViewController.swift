//
//  NotificationViewController.swift
//  LetsEatContentExtension
//
//  Created by Roger Florat on 30/10/2018.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var lblbody: UILabel?
    @IBOutlet weak var lbltitle: UILabel?
    @IBOutlet weak var lblsubtitle: UILabel?
    @IBOutlet weak var imageView: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = view.bounds.size
        preferredContentSize = CGSize(width: size.width, height: 280)
    }
    
    func didReceive(_ notification: UNNotification) {
        
        self.lbltitle?.text = notification.request.content.title
        self.lblsubtitle?.text = notification.request.content.subtitle
        self.lblbody?.text = notification.request.content.body
        
        if let attachment = notification.request.content.attachments.first {
            if attachment.url.startAccessingSecurityScopedResource() {
                if let data = NSData(contentsOfFile: attachment.url.path) as Data? {
                    self.imageView.image = UIImage(data: data)
                    attachment.url.stopAccessingSecurityScopedResource()
                }
            }
        }
    }

}
