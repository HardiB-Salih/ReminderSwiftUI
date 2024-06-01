//
//  ReminderDetailView.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 6/1/24.
//

import SwiftUI

struct ReminderDetailView: View {
    // we user bidning so the update will happen in real time
    @Binding var reminder: Reminder
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid : Bool { !editConfig.title.isEmpty }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Note", text: $editConfig.notes ?? "")
                    }
                    
                    Section {
                        Toggle(isOn: $editConfig.hasDate, label: {
                            Image(systemName: "calendar")
                                .foregroundStyle(Color(.systemRed))
                        })
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date() , displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime, label: {
                            Image(systemName: "clock")
                                .foregroundStyle(Color(.systemBlue))
                        })
                        
                        if editConfig.hasTime {
                            DatePicker("Select Date", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                    }
                    .onChange(of: editConfig.hasDate) { _, newValue in
                        if newValue && editConfig.reminderDate == nil {
                            editConfig.reminderDate = Date()
                        }
                    }

                    .onChange(of: editConfig.hasTime) { _, newValue in
                        if newValue && editConfig.reminderTime == nil {
                            editConfig.reminderTime = Date()
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            SelectListView(selectedList: $reminder.list)
                        } label: {
                            HStack {
                                Text("List")
                                Spacer()
                                Text(reminder.list!.name)
                            }
                        }
                        
                    }
                }
            }.onAppear{
                editConfig = ReminderEditConfig(remindr: reminder)
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done"){
                        do {
                            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        
                        dismiss()
                    }.disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
