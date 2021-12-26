//  Copyright (c) 2020 Quintschaf GbR
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

/// A regular expression match.
public struct SKRegexMatch {
    internal let originalString : NSString
    
    /// The range of the string that was captured.
    public let range : NSRange
    /// The ranges of the strings that were captured for the capture groups.
    public let captureGroupRanges: [NSRange]
    
    /// The string that was captured.
    public var result : String {
        // TODO: Rename?
        return originalString.substring(with: range)
    }
    
    /// The strings that were captured for the capture groups.
    public var captureGroups: [String?] {
        // TODO: Rename 'capturedGroups'?
        return captureGroupRanges.map({ (range) -> String? in
            if range.location == NSNotFound {
                return nil
            }
            return originalString.substring(with: range)
        })
    }
    
    internal init (string : String, textCheckingResult : NSTextCheckingResult) {
        self.originalString = string as NSString
        
        self.range = textCheckingResult.range
        
        var captureGroupRanges:[NSRange] = []
        for rangeIndex in 1..<textCheckingResult.numberOfRanges {
            captureGroupRanges.append(textCheckingResult.range(at: rangeIndex))
        }
        self.captureGroupRanges = captureGroupRanges
    }
}
