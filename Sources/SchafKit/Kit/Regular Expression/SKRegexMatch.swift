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
