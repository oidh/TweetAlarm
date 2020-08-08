//
//  ViewController.swift
//  TweetAlarm
//
//  Created by Oliver James Richards on 14/07/2020.
//  Copyright © 2020 Oliver James Richards. All rights reserved.
//
//  Object oriented programing was trialed, but does not work well in iOS for this kind of simple, system-level integration.
//  As such, the notification objects were treated as the "alarms"

import UIKit
import UserNotifications
import CoreData

class ViewController: UIViewController {
    
    //alarm
    var alarm : Alarm = Alarm()
    
    //core data
    //persistance access
    var alarmCoreDataManager : CoreDataManager = CoreDataManager.init()
    var alarmCoreDataSignature : String = "alarmCoreDataSignature"
    
    // view variables
        @IBOutlet weak var alarmSwitch: UISwitch!
        @IBOutlet weak var alarmTime: UIDatePicker!
        @IBOutlet weak var alarmRepeatsSwitch: UISwitch!
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load core data (or call method to create it)
        let FetchedAlarmCoreData = alarmCoreDataManager.fetchAlarmPersistence()
       
        alarmSwitch.isOn = alarm.alarmEnabled
        alarmTime.date = alarm.alarmDate
        alarmRepeatsSwitch.isOn = alarm.alarmRepeats
        
        }
    
    
    
    //function is run by the viewDidLoad method the first time the app is launched. It sets up the first instance of persistance for the data stored within the alarm clock
    
   
        


    
    
    // method handles toggling of alarm on and off, creating or removing notification
    
    @IBAction func alarmToggled(_ sender: Any) {
        if alarmSwitch.isOn {
            alarm.scheduleAlarm()
            
        alarmCoreDataManager.fetchAlarmPersistence() as AlarmPersistence
            
            
        } else {
            alarm.descheduleAlarm()
        }
    }
    
    // method reschedules alarm notification via the Alarm class
    
    @IBAction func timeChanged(_ sender: Any) {
       
        if (alarmSwitch.isOn) {
            alarm.reschduleAlarm(newTime: alarmTime.date)
        } else {
            alarm.descheduleAlarm()

        }
    }
    
    
    
   
}



