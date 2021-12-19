//
//  DateFormatter.swift
//  
//
//  Created by Jann Schafranek on 19.12.21.
//

import Foundation

extension DateFormatter {
    
    /// Initializes a new `DateFormatter` with the given `dateStyle` and `timeStyle`.
    convenience init(dateStyle: Style, timeStyle: Style) {
        self.init()
        
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
    
    /// Initializes a new `DateFormatter` with the given `dateStyle`.
    convenience init(dateStyle: Style) {
        self.init()
        
        self.dateStyle = dateStyle
        self.timeStyle = .none
    }
    
    /// Initializes a new `DateFormatter` with the given `timeStyle`.
    convenience init(timeStyle: Style) {
        self.init()
        
        self.dateStyle = .none
        self.timeStyle = timeStyle
    }
}
