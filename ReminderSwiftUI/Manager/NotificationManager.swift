//
//  NotificationManager.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 6/2/24.
//

import Foundation
import UserNotifications

// Struct to hold user data for the notification
struct UserData {
    let title: String?  // Notification title
    let body: String?   // Notification body (notes in Reminder)
    let date: Date?     // Date for the notification
    let time: Date?     // Time for the notification
}

let NotificationManager = _NotificationManager()

// Class to manage notifications
class _NotificationManager {

    // Method to schedule a notification
    func scheduleNotification(userData: UserData) {

        let content = UNMutableNotificationContent()
        content.title = userData.title ?? ""   // Set notification title
        content.body = userData.body ?? ""     // Set notification body

        // Create date components from the user data date
        var dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],
                                                            from: userData.date ?? Date())

        // If user data contains time, update hour and minute in date components
        if let reminderTime = userData.time {
            let reminderTimeDataComponent = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
            dateComponent.hour = reminderTimeDataComponent.hour
            dateComponent.minute = reminderTimeDataComponent.minute
        }

        // Create a trigger for the notification
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        // Create a notification request
        let request = UNNotificationRequest(identifier: "Reminder Notification", content: content, trigger: trigger)
        
        // Add the notification request to the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}

//// Usage Example:
//
//// Create a date formatter
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//
//// Create an instance of UserData
//let userData = UserData(
//    title: "Meeting Reminder",
//    body: "Don't forget the meeting at 10 AM.",
//    date: dateFormatter.date(from: "2024-06-02 10:00"),
//    time: dateFormatter.date(from: "2024-06-02 10:00")
//)
//
//// Create an instance of NotificationManager
//let notificationManager = NotificationManager()
//
//// Schedule the notification
//notificationManager.scheduleNotification(userData: userData)
