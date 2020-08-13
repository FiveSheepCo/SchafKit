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
public struct SettingStorage<Value>: Publishable {
    private let key: String
    private var value: Value
    
    init(wrappedValue: Value, key: String) {
        self.key = key
        self.value = (UserDefaults.standard.object(forKey: key) as? Value) ?? wrappedValue
    }
    
    public var wrappedValue: Value {
        get {
            return value
        }
        set {
            value = newValue
            UserDefaults.standard.set(value, forKey: key)
        }
    }
    
    // - MARK: Publishable
    
    public var publisher: PublishablePublisher<Value>?
    
    public var objectWillChange: ObservableObjectPublisher?
}
