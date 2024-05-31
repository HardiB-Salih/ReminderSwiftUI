//
//  HomeView.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 5/31/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showNewList: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello")
                
                Spacer()
                
                Button(action: { showNewList = true }, label: {
                    Text("Add List")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                }).padding()
            }
            .sheet(isPresented: $showNewList, content: {
                AddNewListView(onSave: { name, color in
                   // Save the list to the Database
                    do {
                        try ReminderService.saveMyList(name, color)
                    } catch {
                        print(error.localizedDescription)
                    }
                })
            })
        }
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext,
                      CoreDataProvider.shared.persistentContainer.viewContext)
}
