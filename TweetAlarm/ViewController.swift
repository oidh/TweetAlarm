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
    interfaceSetup()
    
        }
    
    //method sets up the display to match the persistent Alarm data
    func interfaceSetup() {
        
        let alarmDate : Date = alarm.getDate()
    
        print()
        print(alarmDate.debugDescription)
        print()
        
        let alarmEnabled : Bool! = alarm.getEnabled()
        let alarmRepeats : Bool! = alarm.getRepeats()
        
        
        
        
        alarmTime.setDate(alarmDate, animated: false)
//        alarmSwitch.setOn(alarmEnabled , animated: false)
        alarmRepeatsSwitch.setOn(alarmRepeats, animated: false)
        
    }
    
    // method handles toggling of alarm on and off, creating or removing notification
    @IBAction func alarmToggled(_ sender: Any) {
     
        if alarmSwitch.isOn {
            alarm.setEnabled(enabled: true)
            alarm.scheduleAlarm()
        } else {
            alarm.setEnabled(enabled: false)
            alarm.descheduleAlarm()
        }
    }
    
    // method reschedules alarm notification via the Alarm class
    
    @IBAction func timeChanged(_ sender: Any) {
       
        //change time
        alarm.setDate(date: alarmTime.date)
        
        //resschdule notifications
        if (alarmSwitch.isOn) {
            alarm.scheduleAlarm()
        } else {
            alarm.descheduleAlarm()

        }
    }
    
    
    
   
}



