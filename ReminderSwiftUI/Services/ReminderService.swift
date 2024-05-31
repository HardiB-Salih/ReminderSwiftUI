//
//  ReminderService.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 5/31/24.
//

import Foundation
import CoreData
import UIKit

let ReminderService = _ReminderService()
class _ReminderService {
    
    private var viewContext : NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    private func save() throws {
        try viewContext.save()
    }
    
    
    func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    
    
    
    
    
    
    
}
