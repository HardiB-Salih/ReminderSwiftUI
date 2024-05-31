//
//  ReminderSwiftUIApp.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 5/31/24.
//

import SwiftUI

@main
struct ReminderSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext,
                              CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}

// Adding managedObjectContext to the environment so that
// HomeView and its child views have access to the Core Data
// context (viewContext) needed to fetch and manage data.
