//
//  Date + Extention.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 6/1/24.
//

import Foundation

extension Date {
    var isToday : Bool {
        let calender = Calendar.current
        return calender.isDateInToday(self)
    }
    
    var isTomorrow : Bool {
        let calender = Calendar.current
        return calender.isDateInTomorrow(self)
    }
    
    var isYesterday : Bool {
        let calender = Calendar.current
        return calender.isDateInYesterday(self)
    }
    
    var dateComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
    }
}
