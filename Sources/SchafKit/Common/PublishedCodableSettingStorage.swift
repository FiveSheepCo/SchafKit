import Foundation
import Combine

@propertyWrapper
public struct PublishedCodableSettingStorage<Value> where Value: Codable {
    private let key: String
    private var dataHash: Int
    private var value: Value
    
    public init(wrappedValue: Value, key: String) {
        self.key = key
        dataHash = 0
        value = wrappedValue
        self.updateValue()
    }
    
    mutating private func updateValue() {
        guard let data = SettingStorageUserDefaultsInstance.data(forKey: key) else { return }
        
        let newHash = data.hashValue
        
        if newHash == dataHash { return }
        
        dataHash = newHash
        guard let value = try? JSONDecoder().decode(Value.self, from: data) else {
            assertionFailure()
            return
        }
        self.value = value
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
            object[keyPath: storageKeyPath].updateValue()
            return object[keyPath: storageKeyPath].value
        }
        set {
            SKDispatchHelper.dispatchOnMainQueue(sync: false) {
                (object.objectWillChange as! ObservableObjectPublisher).send()
                object[keyPath: storageKeyPath].objectWillChange?.send()
                object[keyPath: storageKeyPath].publisher?.subject.send(newValue)
            }
            object[keyPath: storageKeyPath].value = newValue
            
            let encoded = try! JSONEncoder().encode(newValue)
            object[keyPath: storageKeyPath].dataHash = encoded.hashValue
            SettingStorageUserDefaultsInstance.set(encoded, forKey: object[keyPath: storageKeyPath].key)
        }
        // TODO: Benchmark and explore a possibility to use _modify
    }
}
