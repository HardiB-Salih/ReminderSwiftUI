//
//  ReminderEditConfig.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 6/1/24.
//

import Foundation

struct ReminderEditConfig {
    var title: String = ""
    var notes: String?
    var isCompleted: Bool = false
    var hasDate: Bool = false
    var hasTime: Bool = false
    var reminderDate: Date?
    var reminderTime: Date?
    
    init() { }
    
    init(remindr: Reminder) {
        title = remindr.title ?? ""
        notes = remindr.notes
        isCompleted = remindr.isCompleted
        hasDate = remindr.reminderDate != nil
        hasTime = remindr.reminderTime != nil
        reminderDate = remindr.reminderDate
        reminderTime = remindr.reminderTime
    }
}
