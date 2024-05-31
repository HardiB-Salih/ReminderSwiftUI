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
    
    @State private var showNewList: Bool = false

    
    var body: some View {
        NavigationStack {
            VStack {
                MyListView(myLists: myListResult)
                Spacer()
                
                Button(action: { showNewList = true }, label: {
                    Text("Add List")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                })
            }
            .padding()
            .sheet(isPresented: $showNewList) { addNewListView() }
        }
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
