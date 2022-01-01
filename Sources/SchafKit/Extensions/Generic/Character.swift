import Foundation

public extension Character {
    
    // MARK: - Static Content
    
    /// A space character.
    static let space : Character = " "
    
    /// A newline character.
    static let newline : Character = "\n"
    
    /// A tab character.
    static let tab : Character = "\t"
    
    /**
     Returns a string containing only the receiver.
    
     - Remark : String() does not support optional chaining.
    */
    var toString : String {
        return String(self)
    }
}
