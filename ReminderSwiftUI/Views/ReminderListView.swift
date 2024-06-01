//
//  ReminderListView.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 6/1/24.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: FetchedResults<Reminder>
    @State private var selsectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false

    private func reminderCheckedChanged( reminder: Reminder , isCompleted: Bool) {
        var editConfig = ReminderEditConfig(remindr: reminder)
        editConfig.isCompleted = isCompleted
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selsectedReminder?.objectID == reminder.objectID
    }
    
    
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    var body: some View {
        List {
            ForEach(reminders) { reminder in
                ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                    switch event {
                    case .onSelect(let reminder):
                        selsectedReminder = reminder
                    case .onCheckedChange(let reminder, let isCompleted):
                        reminderCheckedChanged(reminder: reminder, isCompleted: isCompleted)
                    case .onInfo:
                        showReminderDetail = true
                    }
                }
            }
            .onDelete(perform: deleteReminder)
            .sheet(isPresented: $showReminderDetail, content: {
                ReminderDetailView(reminder: Binding($selsectedReminder)!)
            })
        }
        .padding(0)
        .scrollContentBackground(.hidden) // Hide default background
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
        
    }
}

//#Preview {
//    ReminderListView()
//}
