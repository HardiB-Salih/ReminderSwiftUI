//
//  Delay.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 6/1/24.
//

import Foundation

/// A class that provides functionality to delay the execution of a task.
///
/// You can use this class to perform a task after a specified delay or to cancel the task before it executes.
class Delay {
    // The number of seconds to delay the execution of the task.
    private var seconds: Double
    
    // The DispatchWorkItem that represents the work to be performed.
    var workItem: DispatchWorkItem?
    
    /// Initializes a new instance of the `Delay` class.
    ///
    /// - Parameter seconds: The delay in seconds before the task is executed. The default value is 2.0 seconds.
    init(seconds: Double = 2.0) {
        self.seconds = seconds
    }
    
    /// Schedules a task to be performed after the specified delay.
    ///
    /// - Parameter work: The task to be executed.
    func performWork(_ work: @escaping () -> Void) {
        workItem = DispatchWorkItem(block: {
            work()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    
    /// Cancels the scheduled task if it has not yet been executed.
    func cancel() {
        workItem?.cancel()
    }
}

