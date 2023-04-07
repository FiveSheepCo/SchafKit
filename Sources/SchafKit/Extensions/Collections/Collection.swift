import Foundation

public extension Collection {
    
    /// Returns the element at the specified index if it exists, otherwise nil.
    subscript (ifExists index : Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// Returns nil if the collection is empty.
    var nilIfEmpty: Self? {
        if self.isEmpty {
            return nil
        }
        return self
    }
}
