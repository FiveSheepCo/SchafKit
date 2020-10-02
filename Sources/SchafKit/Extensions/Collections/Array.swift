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
#if os(iOS)
import UIKit
#endif

public extension Array {
    
    #if os(iOS)
    /// Shares the items of the responder using a `UIActivityViewController`.
    func share(applicationActivities : [UIActivity]? = nil) {
        let controller : UIActivityViewController
        
        controller = UIActivityViewController(activityItems: self, applicationActivities: applicationActivities)
        
        controller.show(type: .present)
    }
    #endif
    
    /// Removes and returns the first element of the collection, if it exists.
    mutating func removeFirstIfExists() -> Element? {
        if self.isEmpty {
            return nil
        }
        
        return self.removeFirst()
    }
    
    /**
     Removes the specified number of elements from the beginning of the collection, if they exist.
    
     - Note : If less elements than specified exist, they will be removed anyway.
    */
    mutating func removeFirstIfExist(_ n : Int) {
        self.removeFirst(Swift.min(n, self.count))
    }
    
    /// Removes and returns the last element of the collection, if it exists.
    mutating func removeLastIfExists() -> Element? {
        if self.isEmpty {
            return nil
        }
        
        return self.removeLast()
    }
    
    /**
     Removes the specified number of elements from the end of the collection, if they exist.
    
     - Note : If less elements than specified exist, they will be removed anyway.
    */
    mutating func removeLastIfExist(_ n : Int) {
        self.removeLast(Swift.min(n, self.count))
    }
    
    /// Removes all occurances of the given object, but not objects that equal it.
    mutating func remove(exactObject : Element) {
        for i in (0..<self.count).reversed() {
            if self[i] as AnyObject? === exactObject as AnyObject? {
                self.remove(at: i)
            }
        }
    }
    
    /// Returns a Boolean value indicating whether the sequence contains the exact given element.
    func contains(exactObject : Element) -> Bool {
        for i in (0..<self.count).reversed() {
            if self[i] as AnyObject? === exactObject as AnyObject? {
                return true
            }
        }
        return false
    }
    
    /// Test whether anyat element matches the given predicate.
    func any(_ predicate: (Element) -> Bool) -> Bool {
        for item in self {
            if predicate(item) {
                return true
            }
        }
        return false
    }
    
    /// Get the max value of a field of the array element type.
    ///
    /// ```
    /// ["foo", "bar", "toast"].max(by: \.count)
    /// ```
    ///
    /// - Parameter f: A function/keypath returning the value to be compared.
    func max<T: Comparable>(of mappingFunc: (Element) -> T) -> T? {
        self.map(mappingFunc).max()
    }
    
    /// Get the max value of a field of the array element type.
    ///
    /// ```
    /// ["foo", "bar", "toast"].max(by: \.count)
    /// ```
    ///
    /// - Parameter f: A function/keypath returning the optional value to be compared.
    func max<T: Comparable>(of mappingFunc: (Element) -> T?) -> T? {
        self.compactMap(mappingFunc).max()
    }
    
    /// Get the min value of a field of the array element type.
    ///
    /// ```
    /// ["foo", "bar", "toast"].min(by: \.count)
    /// ```
    ///
    /// - Parameter f: A function/keypath returning the value to be compared.
    func min<T: Comparable>(of mappingFunc: (Element) -> T) -> T? {
        self.map(mappingFunc).min()
    }
    
    /// Get the min value of a field of the array element type.
    ///
    /// ```
    /// ["foo", "bar", "toast"].min(by: \.count)
    /// ```
    ///
    /// - Parameter f: A function/keypath returning the optional value to be compared.
    func min<T: Comparable>(of mappingFunc: (Element) -> T?) -> T? {
        self.compactMap(mappingFunc).min()
    }
}

public extension Array where Element : Equatable {
    
    /// Whether the receiver ends with the other array.
    func ends(with possiblePostfix : Array) -> Bool {
        let count = self.count
        let startIndex = count - possiblePostfix.count
        
        guard startIndex >= 0 else {
            return false
        }
        
        return Array(self[startIndex..<count]) == possiblePostfix
    }
    
    /// Returns an array with the duplicates removed.
    func removingDuplicates() -> [Element] {
        var finalArray:[Element] = []
        
        for element in self where !finalArray.contains(element){
            finalArray.append(element)
        }
        
        return finalArray
    }
    
    /// Removes all occurances of the given object.
    mutating func remove(object : Element) {
        for i in (0..<self.count).reversed() {
            if self[i] == object {
                self.remove(at: i)
            }
        }
    }
    
    /// Removes duplicates in an array.
    mutating func removeDuplicates() {
        self = removingDuplicates()
    }
}
