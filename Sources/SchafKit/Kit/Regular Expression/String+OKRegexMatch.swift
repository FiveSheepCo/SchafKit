//
//  String+SKRegexMatch.swift
//  OpenKit-iOS
//
//  Created by Jann Schafranek on 23.06.19.
//  Copyright © 2019 Jann Schafranek. All rights reserved.
//

import Foundation

public extension String {
    
    // MARK: - RegEx
    
    /// Returns whether the receiver is a valid regular expression.
    var isValidRegEx : Bool {
        return (try? NSRegularExpression(pattern: self, options: [])) != nil
    }
    
    /**
     Returns an array of `SKRegexMatch` containing information about matches in the receiver with the given regular expression.
     
     - Parameters:
     - regex : The regular expression to search with.
     - options : The options.
     
     - Note : This only ever returns nil if the regular expression is invalid.
     */
    func regexMatches(with regex : String, options : NSRegularExpression.Options = []) -> [SKRegexMatch]?{
        guard let regex = try? NSRegularExpression(pattern: regex, options: options) else {
            return nil
        }
        
        return regex.matches(in: self).map { (result) -> SKRegexMatch in
            return SKRegexMatch(string: self, textCheckingResult: result)
        }
    }
}
