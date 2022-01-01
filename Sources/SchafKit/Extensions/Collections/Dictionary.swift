import Foundation

public extension Dictionary {
    /// Returns a dictionary containing the keys and values of both dictionaries.
    ///
    /// - Important : In case of conflicts the value in the right dictionary wins.
    static func +(left: [Key : Value], right: [Key : Value]) -> [Key : Value] {
        var final = left
        for keyValuePair in right {
            final[keyValuePair.key] = keyValuePair.value
        }
        return final
    }
    
    /// Adds the keys and values of the right dictionary to the left one.
    ///
    /// - Important : In case of conflicts the value in the right dictionary wins.
    static func +=(left: inout [Key : Value], right: [Key : Value]) {
        left = left + right
    }
}

public extension Dictionary where Value : Equatable {
    
    /// Returns an array of all keys with the given value.
    func keys(for value: Value) -> [Key] {
        var keys:[Key] = []
        
        for keyValuePair in self where keyValuePair.value == value {
            keys.append(keyValuePair.key)
        }
        
        return keys
    }
}

public extension Dictionary where Key : StringProtocol, Value : StringProtocol {
    
    /// Returns a query string made up of the contents of the receiver.
    func toQueryString() -> String {
        var queryString : String = .empty
        for kVP in self {
            queryString += "\(String(kVP.key).urlEncoded)=\(String(kVP.value).urlEncoded)&"
        }
        if queryString.count > 0 {
            queryString.removeLast()
        }
        return queryString
    }
}

