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

/// A JSON representable.
public class OKJsonRepresentable : Sequence {
    /// The current value, if any.
    public let value : Any?
    
    /// Whether the current representable exists.
    public var exists : Bool {
        return value != nil
    }
    
    /// The JSON representation.
    public var jsonRepresentation : Data? {
        guard let value = value else {
            return nil
        }
        
        return try? JSONSerialization.data(withJSONObject: value, options: [])
    }
    
    /// Returns a new `OKJsonRepresentable` with the given object.
    public init (object : Any?) {
        self.value = object
    }
    
    /// Returns a new `OKJsonRepresentable` with the given JSON representation.
    public convenience init (jsonRepresentation : Data?) {
        guard let jsonRepresentation = jsonRepresentation else {
            self.init(object: nil)
            return
        }
        
        self.init(object: try? JSONSerialization.jsonObject(with: jsonRepresentation, options: []))
    }
    
    /// Returns a new `OKJsonRepresentable` with the given JSON representation.
    public convenience init (jsonRepresentation : String?) {
        self.init(jsonRepresentation: jsonRepresentation?.data(using: .utf8))
    }
    
    // MARK: - Subscript
    
    /// Returns a new `OKJsonRepresentable` with the value for the given index, if any.
    public subscript (index : Int) -> OKJsonRepresentable {
        return OKJsonRepresentable(object: arrayValue?[ifExists: index] )
    }
    
    /// Returns a new `OKJsonRepresentable` with the value for the given key, if any.
    public subscript (key : String) -> OKJsonRepresentable {
        return OKJsonRepresentable(object: dictionaryValue?[key] )
    }
    
    // MARK: - Values
    
    /// The `Bool` value.
    public var boolValue : Bool? {
        return value as? Bool
    }
    
    /// The `String` value.
    public var stringValue : String? {
        return value as? String
    }
    
    /// The `NSNumber` value.
    public var numberValue : NSNumber? {
        return value as? NSNumber
    }
    
    /// The `Int` value.
    public var intValue : Int? {
        return numberValue?.intValue
    }
    
    /// The `Double` value.
    public var doubleValue : Double? {
        return numberValue?.doubleValue
    }
    
    /// The `Array` value.
    public var jsonArrayValue : [OKJsonRepresentable]? {
        return (value as? [Any])?.map({ (object) -> OKJsonRepresentable in
            return OKJsonRepresentable(object: object)
        })
    }
    
    /// The `Array` value.
    public var arrayValue : [Any]? {
        return value as? [Any]
    }
    
    /// The `Dictionary` value.
    public var dictionaryValue : [String : Any]? {
        return value as? [String : Any]
    }
    
    // MARK: - Sequence
    
    public func makeIterator() -> IndexingIterator<[OKJsonRepresentable]> {
        return (jsonArrayValue ?? []).makeIterator()
    }
}
