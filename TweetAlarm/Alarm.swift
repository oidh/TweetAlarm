//
//  Alarm.swift
//  TweetAlarm
//
//  Alarm class takes a date as an argument and scehdules a notifcation to go off.
//  Alarm can also be used to deschedule these notifications.

//  Created by Oliver James Richards on 15/07/2020.
//  Copyright © 2020 Oliver James Richards. All rights reserved.
//

import Foundation
import UserNotifications
import CoreData

class Alarm {
    
    // alarm variables - dictates the properties of the alarm set

    var alarmDate : Date
    var alarmEnabled : Bool
    var alarmRepeats : Bool
    
    // formal alarm variables
    
    var alarmContent : UNMutableNotificationContent
    var alarmIdentifier : String = "Tomorrow's Alarm"
    
    // persistance management
    
    
    //first initailiser
    
    init() {
        self.alarmDate = Date()
        self.alarmEnabled = false
        self.alarmRepeats = false
        
    //todo alarm content - placeholder inserted
        
        self.alarmContent = UNMutableNotificationContent()
        self.alarmContent.title = "ALARM!!"
        self.alarmContent.body = "Don't be lazy, or else!"
    
    }
    
    // setters and getters
   
    public func setDate(date : Date) {
        self.alarmDate = date
    }
    
    public func getDate() -> Date {
        return alarmDate
    }
    
    // method converts Date objects as created by the date picker window to DateComponants objects favored by the notification schduler.
    
    func dateToDateComponants(sentDate : Date) -> DateComponents {
            
            let calendar : Calendar = Calendar.current
            let components = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: sentDate)
            
            return components
        }
    
    
    // method schdules the notificaion that acts as the alarm clock to wake the user up in the morning. Alarm is schedules based on instance varibles at the top of the class, edited by the user via the UI.
       
     func scheduleAlarm() {
           
            //bump days
            bumpDays()
        
           //convert to DateComponants
        
            let alarmDateComponents = dateToDateComponants(sentDate: alarmDate)
        
           //create alarm trigger
           let alarmTrigger = UNCalendarNotificationTrigger(dateMatching: alarmDateComponents, repeats: alarmRepeats)
           
            //create notification request
           let alarmRequest = UNNotificationRequest(identifier : alarmIdentifier, content : alarmContent, trigger: alarmTrigger)
            
            //push foreward by a day if before now in time
        
            //create notification
           UNUserNotificationCenter.current().add(alarmRequest)
           
           }
       
    // method allows users to change the time of the alarm, method is called when the time in changed in the ViewController. Must pass the new time.
    
    func reschduleAlarm() {
        descheduleAlarm()
        scheduleAlarm()
        
    }
    
    // method makes the notification repeat
    
    func makeRepeat() {
        alarmRepeats = true
    }
    
    
    // method disables repeated alarm
    
    func disableRepeat() {
        
    }
    
    // method allows user to completely deschedule the alarm, removing the notification from the pending list
    
       func descheduleAlarm() {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
       }
    
    //if the alarm is scheduled after the alloted time in the day, the alarm will sound that day. If the alarm is scheduled earlier in the day, the alarm will be scheduled for the following day. Returns the number of days by which the day date componant should be increesed.
    
    func bumpDays(){
        
        if (alarmDate > Date()){
            alarmDate = alarmDate + 86400 }
    }
}




