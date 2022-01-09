import Combine

@propertyWrapper
public struct EquatablePublished<Value: Equatable> {

    @inlinable // trivially forwarding
    public init(initialValue: Value) {
        self.init(wrappedValue: initialValue)
    }

    /// Initialize the storage of the `EquatablePublished` property as well as the corresponding
    /// `Publisher`.
    public init(wrappedValue: Value) {
        value = wrappedValue
    }

    /// A publisher for properties marked with the `@EquatablePublished` attribute.
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

    private var value: Value

    // swiftlint:disable let_var_whitespace
    @available(*, unavailable, message: """
               @Published is only available on properties of classes
               """)
    public var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() } // swiftlint:disable:this unused_setter_value
    }
    
    // swiftlint:enable let_var_whitespace
    public static subscript<EnclosingSelf: ObservableObject>(
        _enclosingInstance object: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, EquatablePublished<Value>>
    ) -> Value {
        get {
            return object[keyPath: storageKeyPath].value
        }
        set {
            guard object[keyPath: storageKeyPath].value != newValue else { return }
            
            (object.objectWillChange as! ObservableObjectPublisher).send()
            object[keyPath: storageKeyPath].value = newValue
        }
    }
}
