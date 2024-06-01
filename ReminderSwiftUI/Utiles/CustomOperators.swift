//
//  CustomOperators.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 6/1/24.
//


import Foundation
import SwiftUI

/**
 Provides a default value for a `Binding` that wraps an optional value.
 
 - Parameters:
    - lhs: A `Binding` that wraps an optional value.
    - rhs: A default value to use if `lhs` is nil.
 - Returns: A `Binding` that wraps a non-optional value, using the default value if the original binding is nil.
 */

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}



