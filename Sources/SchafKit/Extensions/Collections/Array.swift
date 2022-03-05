import Foundation
#if os(iOS)
import UIKit
#endif

public extension Array {
    
    #if os(iOS)
    /// Shares the items of the responder using a `UIActivityViewController`.
    @available(iOSApplicationExtension, unavailable)
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
    
    /// Test whether any element matches the given predicate.
    ///
    /// ```
    /// ["hello", "world", "", "toast"].any(\.isEmpty) // true
    /// ```
    ///
    /// - Parameter predicate: A function/keypath returning a boolean value.
    func any(_ predicate: (Element) -> Bool) -> Bool {
        for item in self {
            if predicate(item) {
                return true
            }
        }
        return false
    }
    
    /// Test whether no elements match the given predicate.
    ///
    /// ```
    /// ["hello", "world", "toast"].none(\.isEmpty) // true
    /// ```
    ///
    /// - Parameter predicate: A function/keypath returning a boolean value.
    func none(_ predicate: (Element) -> Bool) -> Bool {
        for item in self {
            if predicate(item) {
                return false
            }
        }
        return true
    }
    
    /// Get the max value of a field of the array element type.
    ///
    /// ```
    /// ["foo", "bar", "toast"].max(of: \.count)
    /// ```
    ///
    /// - Parameter mappingFunc: A function/keypath returning the value to be compared.
    func max<T: Comparable>(of mappingFunc: (Element) -> T) -> T? {
        self.map(mappingFunc).max()
    }
    
    /// Get the max value of a field of the array element type.
    ///
    /// ```
    /// ["foo", "bar", "toast"].max(of: \.count)
    /// ```
    ///
    /// - Parameter mappingFunc: A function/keypath returning the optional value to be compared.
    func max<T: Comparable>(of mappingFunc: (Element) -> T?) -> T? {
        self.compactMap(mappingFunc).max()
    }
    
    /// Get the min value of a field of the array element type.
    ///
    /// ```
    /// ["foo", "bar", "toast"].min(of: \.count)
    /// ```
    ///
    /// - Parameter mappingFunc: A function/keypath returning the value to be compared.
    func min<T: Comparable>(of mappingFunc: (Element) -> T) -> T? {
        self.map(mappingFunc).min()
    }
    
    /// Get the min value of a field of the array element type.
    ///
    /// ```
    /// ["foo", "bar", "toast"].min(of: \.count)
    /// ```
    ///
    /// - Parameter mappingFunc: A function/keypath returning the optional value to be compared.
    func min<T: Comparable>(of mappingFunc: (Element) -> T?) -> T? {
        self.compactMap(mappingFunc).min()
    }
    
    /// Get the elements of the array sliced to include at most the first `count` items. If less items than `count` are in the array, all items are returned.
    func sliced(upTo count: Int) -> [Element] {
        Array(self[0..<Swift.min(count, self.count)])
    }
    
    /// The map function but with a `handler` that provides a `callback` for asynchronous operations.
    func asyncMap<T>(handler: (Element, @escaping (T) -> Void) -> Void, completion: @escaping ([T]) -> Void) {
        
        var waitingCount = count
        
        if waitingCount == 0 {
            completion([])
            return
        }
        
        var ids = [UUID]()
        var results = [UUID: T]()
        for item in self {
            let id = UUID()
            ids.append(id)
            
            handler(item, { result in
                results[id] = result
                
                waitingCount -= 1
                if waitingCount == 0 {
                    let resultsSorted = results.sorted(by: { lK, rK in
                        ids.firstIndex(of: lK.key) ?? 0 < ids.firstIndex(of: rK.key) ?? 0
                    }).map { kVP in
                        kVP.value
                    }
                    
                    completion(resultsSorted)
                }
            })
        }
    }
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        sorted { a, b in
            let isAscending = a[keyPath: keyPath] < b[keyPath: keyPath]
            return isAscending == ascending
        }
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
