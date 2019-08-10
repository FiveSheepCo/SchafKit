//  Copyright (c) 2015 - 2019 Jann Schafranek
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

