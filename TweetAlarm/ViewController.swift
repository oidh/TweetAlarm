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
        
    //fetch core data
    initialAlarmFetch()
       
    //setup display
    initialDisplaySetup()
        }
    
    
    
    //function is run by the viewDidLoad method the first time the app is launched. It sets up the first instance of persistance for the data stored within the alarm clock
    
    func initialAlarmFetch() {
        
        //fetch
        let fetchedData = alarmCoreDataManager.fetchAlarmPersistence()
        
        //execute
        alarm.alarmEnabled = fetchedData.alarmEnabled
        alarm.alarmDate = fetchedData.alarmTime!
        alarm.alarmRepeats = fetchedData.alarmRepeats
    }
    
    //function is run by viewDidLoad in order to make the UI conform to the status of the Alarm object.
    
    func initialDisplaySetup() {
        
        alarmSwitch.isOn = alarm.alarmEnabled
        alarmTime.date = alarm.alarmDate
        alarmRepeatsSwitch.isOn = alarm.alarmRepeats
        
    }

    // method handles toggling of alarm on and off, creating or removing notification
    
    @IBAction func alarmToggled(_ sender: Any) {
     
        //ready persistence
        let newPersistence = alarmCoreDataManager.fetchAlarmPersistence()
                   
        if alarmSwitch.isOn {
            
            alarm.scheduleAlarm()
            
            //update persistence
            newPersistence.alarmEnabled = true
            alarmCoreDataManager.updateAlarmPersistance(sent: newPersistence)
            
        } else {
            
            alarm.descheduleAlarm()
            
            //update persistence
            newPersistence.alarmEnabled = false
            alarmCoreDataManager.updateAlarmPersistance(sent: newPersistence)
        
        }
    }
    
    // method reschedules alarm notification via the Alarm class
    
    @IBAction func timeChanged(_ sender: Any) {
       
        //change time
        alarm.alarmDate = alarmTime.date
        
        //resschdule notifications
        if (alarmSwitch.isOn) {
            alarm.reschduleAlarm()
        } else {
            alarm.descheduleAlarm()

        //update persistence
         let fetchedPersistence = alarmCoreDataManager.fetchAlarmPersistence()
            fetchedPersistence.alarmTime = alarm.alarmDate
            alarmCoreDataManager.updateAlarmPersistance(sent: fetchedPersistence)
        }
    }
    
    
    
   
}



