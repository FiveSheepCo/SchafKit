//
//  SettingStorage.swift
//  9List
//
//  Created by Jann Schafranek on 10.08.20.
//  Copyright © 2020 QuintSchaf. All rights reserved.
//

import Foundation
import Combine

@propertyWrapper
public struct CodableSettingStorage<Value>: Publishable where Value: Codable {
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
    
    public var wrappedValue: Value {
        get {
            return value
        }
        set {
            value = newValue
            UserDefaults.standard.set(try! JSONEncoder().encode(value), forKey: key)
        }
    }
    
    // - MARK: Publishable
    
    public var publisher: PublishablePublisher<Value>?
    
    public var objectWillChange: ObservableObjectPublisher?
}
