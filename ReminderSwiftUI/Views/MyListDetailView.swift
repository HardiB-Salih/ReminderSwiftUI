//
//  MyListDetailView.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 5/31/24.
//

import SwiftUI

struct MyListDetailView: View {
    
    let mylist: MyList
    @State private var openAddReminder: Bool = false
    @State var title: String = ""
    
    
    @FetchRequest(sortDescriptors: [])
    private var remonderResults: FetchedResults<Reminder>
    
    init(mylist: MyList) {
        self.mylist = mylist
        _remonderResults = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: mylist))
    }
    
   
    
    var body: some View {
        ZStack (alignment: .bottomTrailing){
            ReminderListView(reminders: remonderResults)
            Button("New Reminder") {
                openAddReminder = true
            }
            .bold()
            .padding(.horizontal)
        }
        .alert("New Reminder", isPresented: $openAddReminder) {
            TextField("Reminder Title", text: $title)
            Button("Cancel", role: .cancel) {
                title = ""
                openAddReminder = false
            }
            Button("Add") {
                saveReminder()
            }
        }
    }
    
    func saveReminder() {
        do {
            try ReminderService.saveReminderToMyList(myList: mylist, reminderTitle: title)
            title = ""
            openAddReminder = false
        } catch {
            print("Failed to save reminder: \(error.localizedDescription)")
        }
    }
}

//#Preview {
//    MyListDetailView(mylist: PreviewData.myList)
//    
//}
