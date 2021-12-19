//
//  File.swift
//  
//
//  Created by Jann Schafranek on 19.12.21.
//

import Foundation
import Combine

@propertyWrapper
public struct PublishedCodableSettingStorage<Value> where Value: Codable {
    private let key: String
    private var value: Value
    
    public init(wrappedValue: Value, key: String) {
        self.key = key
        if let data = UserDefaults.standard.data(forKey: key),
           let value = try? JSONDecoder().decode(Value.self, from: data) {
            self.value = value
        } else {
            self.value = wrappedValue
        }
    }
    
    // - MARK: Publishable
    
    /// A publisher for properties marked with the `@BackrgoundPublished` attribute.
    public struct Publisher: Combine.Publisher {

        public typealias Output = Value

        public typealias Failure = Never

        public func receive<Downstream: Subscriber>(subscriber: Downstream)
            where Downstream.Input == Value, Downstream.Failure == Never
        {
            subject.subscribe(subscriber)
        }

        fileprivate let subject: CurrentValueSubject<Value, Never>

        fileprivate init(_ output: Output) {
            subject = .init(output)
        }
    }

    private var publisher: Publisher?

    internal var objectWillChange: ObservableObjectPublisher?
    
    /// The property that can be accessed with the `$` syntax and allows access to
    /// the `Publisher`
    public var projectedValue: Publisher {
        mutating get {
            if let publisher = publisher {
                return publisher
            }
            let publisher = Publisher(value)
            self.publisher = publisher
            return publisher
        }
    }
    
    @available(*, unavailable, message: """
               @Published is only available on properties of classes
               """)
    public var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }
    
    public static subscript<EnclosingSelf: ObservableObject>(
        _enclosingInstance object: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, PublishedCodableSettingStorage<Value>>
    ) -> Value {
        get {
            return object[keyPath: storageKeyPath].value
        }
        set {
            OKDispatchHelper.dispatchOnMainQueue(sync: false) {
                (object.objectWillChange as! ObservableObjectPublisher).send()
                object[keyPath: storageKeyPath].objectWillChange?.send()
                object[keyPath: storageKeyPath].publisher?.subject.send(newValue)
            }
            object[keyPath: storageKeyPath].value = newValue
            UserDefaults.standard.set(try! JSONEncoder().encode(newValue), forKey: object[keyPath: storageKeyPath].key)
        }
        // TODO: Benchmark and explore a possibility to use _modify
    }
}
