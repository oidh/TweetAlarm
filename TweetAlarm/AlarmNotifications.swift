//
//  AlarmNotifications.swift
//  TweetAlarm
//
//  Class handles all local notifications scheuled by the application.
//  Variables associated with this class all reguard the content and scheduling of notifications.
//
//  Created by Oliver James Richards on 16/08/2020.
//  Copyright © 2020 Oliver James Richards. All rights reserved.
//

import Foundation
import UserNotifications

    let content = UNMutableNotificationContent()
    let userActions = "User Actions"
    let identifier = "alarm"

class AlarmNotifications {

    //notification management
    let notificationCenter = UNUserNotificationCenter.current()
    
    
    // Constructor
    init() {
        content.body = "WAKE UP!"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = userActions
    }
    
    // Method is responsible for scheudling notifications, using a DateComponents object passed by the caller.
    func scheduleNotification(alarmDateComponents : DateComponents) {
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: alarmDateComponents, repeats: true)
        let request = UNNotificationRequest(identifier : identifier, content : content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "End Alarm", options: [.destructive])
        let category = UNNotificationCategory(identifier: userActions, actions: [deleteAction], intentIdentifiers: [], options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    // Method is responsible for descheduling notifications with the global identifier.
    func deschduleAlarm() {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
            print("alarm notification descheduled")
    }
    
    // Method is responsible for creating snooze notifications, which are identical to Alarm notifications, however they bare a different identifier as not to interfere with daily alarm scheudles.
    // Method scheudles snoozes 540 secconds (9 minutes) in the future, or 9 secconds in the future if the application is in demo mode.
    // Method also generates a Tweeter object, and calls the tweet method.
    
    func snooze(demo : Bool) {
        var trigger = UNTimeIntervalNotificationTrigger(timeInterval: 540, repeats: false)
        
        if (demo) {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 9, repeats: false)
        }
        
        let request = UNNotificationRequest(identifier : "snooze", content : content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        let tweeter = Tweeter()
        tweeter.tweet()
        print("tweet posted")
    }
    
    
    
    
}
