//
//  UIColorTransformer.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 5/31/24.
//

import UIKit

// The UIColorTransformer class is a custom value transformer for Core Data.
// It handles the transformation of UIColor objects to Data and vice versa,
// allowing UIColor objects to be stored in and retrieved from Core Data.

class UIColorTransformer: ValueTransformer {
    
    // This method transforms a UIColor object into Data for storage in Core Data.
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else { return nil }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    // This method reverses the transformation, converting Data back into a UIColor object.
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
            return color
        } catch {
            return nil
        }
    }
}

// Usage: Add any transformers you create to the CoreDataProvider to enable
// Core Data to handle custom types such as UIColor. This transformer
// ensures that UIColor can be archived and unarchived securely for storage
// and retrieval from Core Data.
