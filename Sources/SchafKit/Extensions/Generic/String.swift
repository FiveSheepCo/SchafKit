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

public extension String {
    
    // MARK: - Static Content
    
    /// An empty string.
    static let empty : String = ""
    
    /// A string containing a space character.
    static let space : String = " "
    
    /// A string containing a newline character.
    static let newline : String = "\n"
    
    /// A string containing a tab character.
    static let tab : String = "\t"
    
    // MARK: - States
    
    /// Whether the receiver ends with the other string.
    func ends(with string : String) -> Bool {
        let from = self.count - string.count
        guard from >= 0 else {
            return false
        }
        return self[from...] == string
    }
    
    /// Returns all components seperated by newline characters.
    var lines:[String]{
        return components(separatedBy: .newlines)
    }
    
    // MARK: - Versions
    
    /// A localized version of the receiver.
    var localized : String {
        return self.localized()
    }
    
    /// A URL-encoded version of the receiver.
    var urlEncoded : String {
        // TODO: Option to percent encode space
        var allowedCharacters = CharacterSet.alphanumerics
        allowedCharacters.insert(charactersIn: "-_.~ ")
        
        return (self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? self).replacingOccurrences(of: " ", with: "+")
    }

    /// A URL-decoded version of the receiver.
    var urlDecoded : String {
        return self.removingPercentEncoding ?? self
    }
    
    /// A version of the receiver which has all occurences of the other string replaced with nothing.
    func removingOccurances(of string : String) -> String {
        return replacingOccurrences(of: string, with : String.empty)
    }
    
    /// A version of the receiver which has all occurences of the other string at the start replaced with nothing.
    func removingOccurancesAtStart(of string : String) -> String {
        var new = self
        while new.starts(with: string){
            new = new[string.count...]
        }
        return new
    }
    
    /// A version of the receiver which has all occurences of the other string at the end replaced with nothing.
    func removingOccurancesAtEnd(of string : String) -> String {
        var new = self
        while new.ends(with: string){
            new = new[..<(new.count - string.count)]
        }
        return new
    }
    
    // MARK: - Mutating Functions
    
    /// Capitalizes the receiver.
    mutating func capitalize(){
        self = self.capitalized
    }
    
    /// Lowercases the receiver.
    mutating func lowercase(){
        self = self.lowercased()
    }
    
    /// Uppercases the receiver.
    mutating func uppercase(){
        self = self.uppercased()
    }
    
    /// Replaces all occurances of a string with another string.
    mutating func replaceOccurances(of string : String, with : String){
        self = self.replacingOccurrences(of: string, with: with)
    }
    
    /// Removes all occurances of the given string.
    mutating func removeOccurances(of string : String){
        self = self.removingOccurances(of: string)
    }
    
    /// URL-encodes the receiver.
    mutating func urlEncode(){
        self = self.urlEncoded
    }
    
    /// URL-decodes the receiver.
    mutating func urlDecode(){
        self = self.urlDecoded
    }
    
    // MARK: - Localization
    
    // Returns a localized version of the receiver.
    func localized(with comment : String = .empty) -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    // MARK: - Useful Additions
    
    /**
     Returns an integer version of the receiver, if available.
    
     - Remark : Int() does not support optional chaining.
    */
    var toInt : Int?{
        // TODO: Better name for this?
        // TODO: Make this non-optional? Pros/Cons?
        return Int(self)
    }
    
    /**
     Returns a double version of the receiver, if available.
    
     - Remark : Double() does not support optional chaining.
    */
    var toDouble : Double?{
        return Double(self)
    }
    
    /**
     Returns a double version of the receiver, if available.
    
     - Note : This also respects region settings. (E.g. In some countries '.' and ',' are used the opposite way)
    
     - Remark : Double() does not support optional chaining.
    */
    func formattedToDouble(separatesThousands : Bool = true, locale: Locale = .autoupdatingCurrent) -> Double?{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = separatesThousands
        formatter.groupingSize = 3
        formatter.locale = locale
        return formatter.number(from: self)?.doubleValue
    }
    
    /**
     Extracts number of seconds from the receiver in a hh:mm:ss/mm:ss/ss format.
    
     - Note:
      The receiver is not restricted to having two digits for each component. Any amount is acceptable.
    
     • Example:
     ```
     let time : String = "00:02:15"
     let seconds = time.extractedSeconds // 135
     ```
    */
    var extractedSeconds : Int {
        // TODO: Put this into something like a "OKDateTimeHelper" class?
        
        let comps = Array(self.components(separatedBy: ":").reversed())
        
        let seconds = comps[ifExists: 0]?.toInt ?? 0
        let minutes = comps[ifExists: 1]?.toInt ?? 0
        let hours = comps[ifExists: 2]?.toInt ?? 0
        
        return seconds + minutes * OKTimeUnit.minute.convertInteger(to: .second) + hours * OKTimeUnit.hour.convertInteger(to: .second)
    }
    
    // MARK: - Subscript
    
    /**
     Returns an actual index for an integer.
     
     - Remark : The built-in index system is burdensome.
     */
    func indexAt(_ index : Int) -> String.Index {
        return self.index(self.startIndex, offsetBy: index)
    }
    
    /**
     Returns an actual range for an NSRange.
     
     - Remark : The built-in index system is burdensome.
     */
    func rangeFor(_ range : NSRange) -> Range<String.Index> {
        return indexAt(range.location)..<indexAt(range.location+range.length)
    }
    
    /**
     Returns the character at the specified index.
     
     - Remark: The built-in subscringing system is burdensome.
     */
    subscript (_ index: Int) -> Character {
        self[self.indexAt(index)]
    }
    
    /**
     Returns a new string containing the characters of the receiver within the range.
    
     - Remark : The built-in substringing system is burdensome.
    */
    subscript (_ range : Range<Int>) -> String {
        return String(self[indexAt(range.lowerBound)..<indexAt(range.upperBound)])
    }
    
    /**
     Returns a new string containing the characters of the receiver within the range.
    
     - Remark : The built-in substringing system is burdensome.
    */
    subscript (_ range : CountableClosedRange<Int>) -> String {
        return String(self[indexAt(range.lowerBound)...indexAt(range.upperBound)])
    }
    
    /**
     Returns a new string containing the characters of the receiver from the one at an index.
    
     - Remark : The built-in substringing system is burdensome.
    */
    subscript (_ range : CountablePartialRangeFrom<Int>) -> String {
        return String(self[indexAt(range.lowerBound)...])
    }
    
    /**
     Returns a new string containing the characters of the receiver to the one at an index.
    
     - Remark : The built-in substringing system is burdensome.
    */
    subscript (_ range : PartialRangeUpTo<Int>) -> String {
        return String(self[..<indexAt(range.upperBound)])
    }
    
    /**
     Returns a new string containing the characters of the receiver to the one at an index.
    
     - Remark : The built-in substringing system is burdensome.
    */
    subscript (_ range : PartialRangeThrough<Int>) -> String {
        return String(self[...indexAt(range.upperBound)])
    }
    
    /**
     Returns a new string containing the characters of the receiver within the range.
     
     - important: This does not return the same result as `NSString.substring(with:)`. It uses actual characters in oppose to `NSString` which uses utf16 characters.
    */
    subscript (_ aRange: NSRange) -> String {
        return self[aRange.location..<aRange.upperBound]
    }
    
    /// Appends a utf8 encoded datarepresentation of the receiver to the file at the given url.
    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
}

// - MARK: Identifiable

extension String: Identifiable {
    public var id: String {
        return self
    }
}
