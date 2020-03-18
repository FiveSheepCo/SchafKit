//
//  OrderedDictionary.swift
//  
//
//  Created by Jann Schafranek on 18.03.20.
//

import Foundation

public class OrderedDictionary<Key: Equatable, Value>: Sequence {
    private var keys: [Key] = []
    private var values: [Value] = []
    
    public subscript(key: Key) -> Value? {
        get {
            if let index = keys.firstIndex(of: key) {
                return values[index]
            }
            return nil
        }
        set {
            if let index = keys.firstIndex(of: key) {
                if let newValue = newValue {
                    values[index] = newValue
                } else {
                    keys.remove(at: index)
                    values.remove(at: index)
                }
            } else {
                if let newValue = newValue {
                    keys.append(key)
                    values.append(newValue)
                }
            }
        }
    }
    
    public func makeIterator() -> IndexingIterator<[(Key, Value)]> {
        (0..<keys.count).map { (index) -> (Key, Value) in
            return (keys[index], values[index])
        }.makeIterator()
    }
}
