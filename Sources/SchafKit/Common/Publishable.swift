//
//  Publishable.swift
//  9List
//
//  Created by Jann Schafranek on 12.08.20.
//  Copyright © 2020 QuintSchaf. All rights reserved.
//

import Combine

public protocol Publishable {
    associatedtype Value
    
    var wrappedValue: Value { get set }
    
    var publisher: PublishablePublisher<Value>? { get set }
    
    var objectWillChange: ObservableObjectPublisher? { get set }
}

/// A publisher for properties marked with the `@Published` attribute.
public struct PublishablePublisher<Value>: Combine.Publisher {
    
    public typealias Output = Value
    
    public typealias Failure = Never
    
    public func receive<Downstream: Subscriber>(subscriber: Downstream)
    where Downstream.Input == Value, Downstream.Failure == Never
    {
        subject.subscribe(subscriber)
    }
    
    public let subject: Combine.CurrentValueSubject<Value, Never>
    
    public init(_ output: Output) {
        subject = .init(output)
    }
}

public extension Publishable {
    
    
    /// The property that can be accessed with the `$` syntax and allows access to
    /// the `Publisher`
    var projectedValue: PublishablePublisher<Value> {
        mutating get {
            if let publisher = publisher {
                return publisher
            }
            let publisher = PublishablePublisher(wrappedValue)
            self.publisher = publisher
            return publisher
        }
    }
    
    static subscript<EnclosingSelf: ObservableObject>(
        _enclosingInstance object: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Value {
        get {
            return object[keyPath: storageKeyPath].wrappedValue
        }
        set {
            (object.objectWillChange as! ObservableObjectPublisher).send()
            object[keyPath: storageKeyPath].objectWillChange?.send()
            object[keyPath: storageKeyPath].publisher?.subject.send(newValue)
            object[keyPath: storageKeyPath].wrappedValue = newValue
        }
    }
}
