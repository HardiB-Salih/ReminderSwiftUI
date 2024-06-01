//
//  MyList+CoreDataClass.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 5/31/24.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { ($0 as! Reminder)} ?? []
    }
}
