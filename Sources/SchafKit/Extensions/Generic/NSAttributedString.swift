import Foundation

public extension NSAttributedString {
    
    static func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let new = NSMutableAttributedString(attributedString: lhs)
        new.append(rhs)
        return new
    }
}
