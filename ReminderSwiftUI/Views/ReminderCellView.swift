//
//  ReminderCellView.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 6/1/24.
//

import SwiftUI


enum ReminderCellEvents {
    case onInfo
    case onCheckedChange(Reminder, Bool)
    case onSelect(Reminder)
}

struct ReminderCellView: View {
    let delay = Delay()
    let reminder: Reminder
    let isSelected: Bool

    @State private var checked: Bool = false

    // create enum to hold open for the same closure
    let onEvent: (ReminderCellEvents) -> Void
    
    
    private func formatedDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    
    
    var body: some View {
        HStack (alignment: .top){
            Image(systemName: checked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    checked.toggle()
                    //cancel the old task
                    delay.cancel()
                    //call onCheckedChange inside the delay
                    delay.performWork {
                        onEvent(.onCheckedChange(reminder, checked))
                    }
                }
            
            VStack (alignment: .leading){
                Text(reminder.title ?? "")
                    .bold()
                
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .opacity(0.4)
                }
                
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formatedDate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .opacity(0.4)
            }
            
            Image(systemName: "info.circle.fill")
                .font(.title2)
                .opacity(isSelected ? 0.8 : 0.0)
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }
        .onAppear {
            checked = reminder.isCompleted
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect(reminder))
        }
    }
}

//#Preview {
//    ReminderCellView(reminder: PreviewData.reminder) { _ in
//        
//    }
//}
