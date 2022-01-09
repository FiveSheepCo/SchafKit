import Foundation
import Combine

/// The user defaults instance to use to store Settings. This applies to `SettingsStorage`, `PublishedSettingStorage`, `CodableSettingStorage` and `PublishedCodableSettingStorage`.
public var SettingStorageUserDefaultsInstance: UserDefaults = .standard

@propertyWrapper
public struct SettingStorage<Value>: Publishable {
    
    private let key: String
    private var value: Value
    
    public init(wrappedValue: Value, key: String) {
        self.key = key
        self.value = (SettingStorageUserDefaultsInstance.object(forKey: key) as? Value) ?? wrappedValue
    }
    
    public var wrappedValue: Value {
        get {
            return value
        }
        set {
            value = newValue
            SettingStorageUserDefaultsInstance.set(value, forKey: key)
        }
    }
    
    // - MARK: Publishable
    
    public var publisher: PublishablePublisher<Value>?
    
    public var objectWillChange: ObservableObjectPublisher?
}
