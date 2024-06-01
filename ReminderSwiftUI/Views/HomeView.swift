//
//  HomeView.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 5/31/24.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResult: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatsType(statTypes: .today))
    private var todayResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatsType(statTypes: .all))
    private var allResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatsType(statTypes: .schedule))
    private var scheduleResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatsType(statTypes: .complete))
    private var completeResults: FetchedResults<Reminder>
    
    
    
    
    
    @State private var showNewList: Bool = false
    @State private var search: String = ""
    @State private var isSearhing: Bool = false
    
    private var reminderStateBuilder = ReminderStatsBuilder()
    @State private var reminderStateValue = ReminderStatsValues()
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottomTrailing){
                ScrollView {
                    VStack {
                        HStack {
                            
                            NavigationLink {
                                ReminderListView(reminders: todayResults)
                            } label: {
                                ReminderStatsView(icon: "calendar", title: "Today", count: reminderStateValue.todayCount, iconColor: Color(.systemRed))
                            }
                            
                            NavigationLink {
                                ReminderListView(reminders: scheduleResults)
                            } label: {
                                ReminderStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderStateValue.scheduledCount, iconColor: Color(.systemMint))
                            }
                           
                        }
                        HStack {
                            NavigationLink {
                                ReminderListView(reminders: allResults)
                            } label: {
                                ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStateValue.allCount, iconColor: Color(.systemGray))
                            }
                            NavigationLink {
                                ReminderListView(reminders: completeResults)
                            } label: {
                                ReminderStatsView(icon: "checkmark.circle.fill",
                                                  title: "Completed",
                                                  count: reminderStateValue.completedCount,
                                                  iconColor: Color(.systemGreen))
                            }
                            
                            
                        }
                        
                        
                        Text("My List")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        
                        
                        MyListView(myLists: myListResult)
                    }
                    .foregroundStyle(Color(.label))
                    .navigationTitle("Reminder")
                    .onAppear {
                        reminderStateValue = reminderStateBuilder.build(myListResult: myListResult)
                    }
                    .onChange(of: search, { _ , searchTerm in
                        isSearhing = !searchTerm.isEmpty ? true : false
                        searchResults.nsPredicate = ReminderService.getReminderBySearchTerm(searchTerm).predicate
                    })
                    .overlay(alignment: .center) {
                        if isSearhing{
                            ReminderListView(reminders: searchResults)
                        }
                    }
                    
                    .padding()
                    .sheet(isPresented: $showNewList) { addNewListView() }
                }
                
                Button(action: { showNewList = true }, label: {
                    Text("Add List")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                })
                .padding(.horizontal)
            }
            
        }
        .searchable(text: $search)
    }
    
    
    
    private func addNewListView() -> some View {
        AddNewListView(onSave: { name, color in
            do {
                try ReminderService.saveMyList(name, color)
            } catch {
                print(error.localizedDescription)
            }
        })
    }
    
    
    
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext,
                      CoreDataProvider.shared.persistentContainer.viewContext)
}
