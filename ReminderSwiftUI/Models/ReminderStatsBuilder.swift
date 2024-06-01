//
//  ReminderStatsBuilder.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 6/1/24.
//

import Foundation
import SwiftUI

enum ReminderStatType {
    case today
    case all
    case schedule
    case complete
}

/// A struct that stores counts for various reminder statistics.
struct ReminderStatsValues {
    var todayCount: Int = 0
    var scheduledCount: Int = 0
    var allCount: Int = 0
    var completedCount: Int = 0
}

/// A struct responsible for building `ReminderStatsValues` from a list of reminders.
struct ReminderStatsBuilder {
    
    /// Builds the reminder statistics values from the provided fetched results of `MyList`.
    ///
    /// - Parameter myListResult: The fetched results of `MyList`.
    /// - Returns: A `ReminderStatsValues` object containing the calculated statistics.
    func build(myListResult: FetchedResults<MyList>) -> ReminderStatsValues {
        let remindersArray = myListResult.map { $0.remindersArray }.reduce([], +)
        
        let todayCount = calculateTodayCount(reminders: remindersArray)
        let scheduledCount = calculateScheduledCount(reminders: remindersArray)
        let allCount = calculateAllCount(reminders: remindersArray)
        let completedCount = calculateCompletedCount(reminders: remindersArray)
        
        return ReminderStatsValues(todayCount: todayCount,
                                   scheduledCount: scheduledCount,
                                   allCount: allCount,
                                   completedCount: completedCount)
    }
    
    /// Calculates the count of reminders that are scheduled for today.
    ///
    /// - Parameter reminders: An array of `Reminder` objects.
    /// - Returns: The count of reminders that are scheduled for today.
    func calculateTodayCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1 : result
        }
    }
    
    /// Calculates the count of scheduled reminders.
    ///
    /// - Parameter reminders: An array of `Reminder` objects.
    /// - Returns: The count of scheduled reminders.
    func calculateScheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return ((reminder.reminderDate != nil || reminder.reminderTime != nil) && !reminder.isCompleted) ? result + 1 : result
        }
    }
    
    /// Calculates the count of all incomplete reminders.
    ///
    /// - Parameter reminders: An array of `Reminder` objects.
    /// - Returns: The count of all incomplete reminders.
    func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return !reminder.isCompleted ? result + 1 : result
        }
    }
    
    /// Calculates the count of completed reminders.
    ///
    /// - Parameter reminders: An array of `Reminder` objects.
    /// - Returns: The count of completed reminders.
    func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result + 1 : result
        }
    }
    
    
    
}
