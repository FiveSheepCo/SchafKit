import Foundation

public extension NSMutableAttributedString {
    
    /**
     Adds an attribute with the given name and value to the entire receiver.
     */
    func addAttribute(_ name: NSAttributedString.Key, value : Any){
        addAttribute(name, value: value, range: NSRange(location: 0, length: self.length))
    }
    
    /**
     Removes the named attribute from the characters in the entire receiver.
     */
    func removeAttribute(_ name: NSAttributedString.Key){
        removeAttribute(name, range: NSRange(location: 0, length: self.length))
    }
    
    /**
     Adds the characters of a given string to the end of the receiver.
     */
    func append(_ string: String){
        append(NSAttributedString(string: string))
    }
    
    /**
     Adds the given character to the end of the receiver.
     */
    func append(_ character: Character){
        append(NSAttributedString(string: String(character)))
    }
}
