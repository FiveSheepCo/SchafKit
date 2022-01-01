import Foundation

public extension NSRegularExpression {
    
    /// Returns an initialized NSRegularExpression instance with the specified regular expression pattern.
    convenience init (pattern : String) throws {
        try self.init(pattern: pattern, options: [])
    }
    
    /**
     Returns an array containing all the matches of the regular expression in the string.
    
     - Parameters:
       - string : The string to search.
    */
    func matches(in string : String) -> [NSTextCheckingResult]{
        return matches(in: string, options: [], range : NSMakeRange(0, string.count))
    }
}
