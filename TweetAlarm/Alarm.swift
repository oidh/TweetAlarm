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
import SwiftDate


class Alarm {
    
    //demo mode
    var demoMode : Bool = true
    
    
    //tomorrow, used for notification scheduling

    // alarm variables - dictates the properties of the alarm set
 
    var alarmHour : Int
    var alarmMinute : Int

    var alarmEnabled : Bool
    var alarmRepeats : Bool

    //alarm uses UserDeafaults to implement persistence of these properties
    let defaults = UserDefaults.standard
    
    //data structure looks after persisence access
    struct Keys {
        static let alarmEnabled = "alarmEnabled"
        static let alarmRepeats = "alarmRepeats"
        static let alarmHour = "alarmHour"
        static let alarmMinute = "alarmMinute"
    }
    
    // notification content alarm variables
    var alarmContent : UNMutableNotificationContent
    var notificationIdentifier : String = "Tomorrow's Alarm"
    

    init() {
                
        if (defaults.object(forKey: Keys.alarmHour) == nil) {
    
        defaults.set(8, forKey: Keys.alarmHour)
        defaults.set(0, forKey: Keys.alarmMinute)
            
        defaults.set(false , forKey: Keys.alarmEnabled)
        defaults.set(false, forKey: Keys.alarmEnabled)
               
        print("App has been launched for the first time, fresh preferences have been generated and saved.")
       }
                
        //object setup
     
        self.alarmMinute = defaults.integer(forKey: Keys.alarmMinute)
        self.alarmHour = defaults.integer(forKey: Keys.alarmHour)
        
        self.alarmEnabled = defaults.bool(forKey: Keys.alarmEnabled)
        self.alarmRepeats = defaults.bool(forKey: Keys.alarmRepeats)
        
        //alarm sound

        
        //todo alarm content - placeholder inserted
        self.alarmContent = UNMutableNotificationContent()
        self.alarmContent.title = "ALARM!!"
        self.alarmContent.body = "Don't be lazy, or else!"
    }

    // setters and getters
    
    public func setDate(date : Date) {
    
    //strip to componants
    let componants  = dateToDateComponants(sentDate: date)
    
    //parse minutes
    self.alarmMinute = componants.minute!
        defaults.set(alarmMinute, forKey: Keys.alarmMinute)
        
   //parse secconds
    self.alarmHour = componants.hour!
        defaults.set(alarmHour, forKey: Keys.alarmHour)
        
    }
    
    public func getHour() -> Int {
        return self.alarmHour
    }
    
    public func getMinute() -> Int {
           return self.alarmMinute
    }
    
    public func setHour(hour : Int) {
        self.alarmHour = hour
        defaults.set(hour, forKey: Keys.alarmHour)
    }
    
    public func setMinute(minute : Int) {
          self.alarmMinute = minute
        defaults.set(minute, forKey: Keys.alarmMinute)
      }
    
    public func setEnabled(enabled : Bool) {
        defaults.set(enabled, forKey: Keys.alarmEnabled)
        self.alarmEnabled = enabled
    }
    
    public func getEnabled() -> Bool {
        return self.alarmEnabled
    }
    
    public func setRepeats(repeats : Bool) {
        defaults.set(repeats, forKey: Keys.alarmRepeats)
        self.alarmRepeats = repeats
    }
    
    public func getRepeats() -> Bool {
        return self.alarmRepeats
    }
    
    public func getDate() -> Date{
        
        let date = Date()
        print(date.debugDescription)
        var dateComponents = dateToDateComponants(sentDate: date)
        dateComponents.minute = alarmMinute
        dateComponents.hour = alarmHour
        
        return makeDate(year: dateComponents.year!, month: dateComponents.month!, day: dateComponents.day!, hr: dateComponents.hour!, min: dateComponents.minute!)
        
        
    }
    
    func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int) -> Date {
        var calendar = Calendar.current
        // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: 0)
        return calendar.date(from: components)!
    }
    
    
    
    // method converts Date objects as created by the date picker window to DateComponants objects favored by the notification schduler.
    
    func dateToDateComponants(sentDate : Date) -> DateComponents {
            
            let calendar : Calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.minute, Calendar.Component.hour, Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: sentDate)
        
    
        print()
        print("the following describes the datecomponents")
        print(components.description)
        
            return components
        }
    
    

    // method schdules the notificaion that acts as the alarm clock to wake the user up in the morning. Alarm is schedules based on instance varibles at the top of the class, edited by the user via the UI.
       
     func scheduleAlarm() {
           
        //always deschedule an alarm is scheduling an alarm
        descheduleAlarm()
        
        //generate new date
        var newDate = Date()
        
        //advance by a day if in normal mode
        
        if (demoMode == false) {
        newDate = newDate.advanced(by: 86400)
        }
        
        //setup date components
        var alarmDateComponents : DateComponents = dateToDateComponants(sentDate: newDate)
        
        //change hours and minutes
        alarmDateComponents.hour = alarmHour
        alarmDateComponents.minute = alarmMinute
    
        //create alarm trigger
        let alarmTrigger = UNCalendarNotificationTrigger(dateMatching: alarmDateComponents, repeats: alarmRepeats)
        
        //create notification request
        let alarmRequest = UNNotificationRequest(identifier : notificationIdentifier, content : alarmContent, trigger: alarmTrigger)
            
        //create notification
        UNUserNotificationCenter.current().add(alarmRequest)
       
           }
            
        //method allows user to completely deschedule the alarm, removing the notification from the pending list
    
       func descheduleAlarm() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("alarm notification descheduled")
       }
    
}




