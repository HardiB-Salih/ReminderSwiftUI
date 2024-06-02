//
//  ReminderService.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 5/31/24.
//

import Foundation
import CoreData
import UIKit

/// Singleton instance for the reminder service
let ReminderService = _ReminderService()

/// Service for managing reminders and lists
class _ReminderService {
    
    /// The managed object context for the Core Data stack
    private var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    /// Saves the current state of the managed object context
    ///
    /// - Throws: An error if the save operation fails
    private func save() throws {
        try viewContext.save()
    }
    
    /// Creates and saves a new list with the given name and color
    ///
    /// - Parameters:
    ///   - name: The name of the list
    ///   - color: The color of the list
    /// - Throws: An error if the save operation fails
    func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    
    /// Creates and saves a new reminder in the specified list
    ///
    /// - Parameters:
    ///   - myList: The list to add the reminder to
    ///   - reminderTitle: The title of the reminder
    /// - Throws: An error if the save operation fails
    func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
    
    /// Fetches reminders that belong to the specified list and are not completed
    ///
    /// - Parameter myList: The list to fetch reminders for
    /// - Returns: A fetch request for the reminders
    func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", myList)
        return request
    }
    
    /// Updates a reminder with the provided configuration
    ///
    /// - Parameters:
    ///   - reminder: The reminder to update
    ///   - editConfig: The configuration with the updated values
    /// - Returns: A boolean indicating if the update was successful
    /// - Throws: An error if the save operation fails
    func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool {
        reminder.isCompleted = editConfig.isCompleted
        reminder.title = editConfig.title
        reminder.notes = editConfig.notes
        reminder.reminderDate = editConfig.hasDate ? editConfig.reminderDate : nil
        reminder.reminderTime = editConfig.hasTime ? editConfig.reminderTime : nil
        try save()
        return true
    }
    
    /// Deletes the specified reminder
    ///
    /// - Parameter reminder: The reminder to delete
    /// - Throws: An error if the save operation fails
    func deleteReminder(_ reminder: Reminder) throws {
        viewContext.delete(reminder)
        try save()
    }
    
    /// Fetches reminders that contain the specified search term in their title
    ///
    /// - Parameter searchTeam: The search term to filter reminders by
    /// - Returns: A fetch request for the reminders
    func getReminderBySearchTerm(_ searchTerm: String) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchTerm)
        return request
    }
    
    /// Fetches reminders based on the specified statistic type
    ///
    /// - Parameter statTypes: The type of statistic to filter reminders by
    /// - Returns: A fetch request for the reminders
    func remindersByStatsType(statTypes: ReminderStatType) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        
        switch statTypes {
        case .today:
            let today = Date()
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
            request.predicate = NSPredicate(format: "(reminderDate >= %@) AND (reminderDate < %@)", today as NSDate, tomorrow! as NSDate)
        case .all:
            request.predicate = NSPredicate(format: "isCompleted = false")
        case .schedule:
            request.predicate = NSPredicate(format: "(reminderDate != nil OR reminderTime != nil) AND isCompleted = false")
        case .complete:
            request.predicate = NSPredicate(format: "isCompleted = true")
        }
        
        return request
    }
}
