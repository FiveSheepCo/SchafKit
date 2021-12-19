//
//  URL.swift
//  
//
//  Created by Jann Schafranek on 19.12.21.
//

import Foundation

extension URL {
    
    private enum Constants {
        static let webURLSchemes = ["http", "https"]
    }

    /// Creates a URL with the specified web string, but only when it is an http or https scheme.
    init?(webString: String) {
        self.init(string: webString)
        
        if !Constants.webURLSchemes.contains(scheme ?? .empty) {
            return nil
        }
    }
}
