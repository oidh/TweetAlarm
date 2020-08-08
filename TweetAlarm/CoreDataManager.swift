//
//  AlarmCoreDataManager.swift
//  TweetAlarm
//
//  Created by Oliver James Richards on 31/07/2020.
//  Copyright © 2020 Oliver James Richards. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class CoreDataManager {
    
  let alarmReference = "AlarmPersistenceEntry"
    
    
    init() {
    }
    public func fetchAlarmPersistence() -> AlarmPersistence {
    
    //setup fetch
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<AlarmPersistence>(entityName: "Alarm Persistence")
    
    //call fetch catching errors
        do {
        let returnable = try context.fetch(fetchRequest)
            return returnable.first
        } catch {
        print("Fetch from AlarmPersistence failed")
        }
        let newAlarmPersistence : AlarmPersistence = createAlarmPersistence()
        return newAlarmPersistence
        
    }
    
    public func updateAlarmPersistance(sent : AlarmPersistence) {
        
    //setup context
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    //call save catching errors
        do {
            try context.save()
        } catch {
            print("Failed to update.")
                }
        }

    public func createAlarmPersistence() -> AlarmPersistence {
        //setup context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //create new persistence
        let NewAlarmPersistence = NSEntityDescription.insertNewObject(forEntityName: alarmReference, into: context) as! AlarmPersistence
        
        NewAlarmPersistence.alarmEnabled = false
        NewAlarmPersistence.alarmTime = Date()
        NewAlarmPersistence.alarmRepeats = false
        
        //save context
        
        do {
            try context.save()
                return NewAlarmPersistence
        } catch {
            print("ragamuffin")
                return NewAlarmPersistence
        }
            
        
        
    }
    
    
public func deleteAlarmPersitance(sent : AlarmPersistence) {
    
    //setup context
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    //execute deletion
    context.delete(sent)

        
        
        
}
}
