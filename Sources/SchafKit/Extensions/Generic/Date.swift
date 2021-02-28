//
//  Date.swift
//  
//
//  Created by Marco Quinten on 28.02.21.
//

import Foundation

extension Date {
    
    /// The time interval between  the current date and time and the date value.
    ///
    /// - NOTE: This is the negation of `timeIntervalSinceNow`.
    var timeIntervalUntilNow: TimeInterval {
        -timeIntervalSinceNow
    }
}
