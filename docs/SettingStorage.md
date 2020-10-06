# SettingStorage

``` swift
@propertyWrapper public struct SettingStorage<Value>: Publishable
```

## Inheritance

[`Publishable`](/Publishable)

## Initializers

### `init(wrappedValue:key:)`

``` swift
public init(wrappedValue: Value, key: String)
```

## Properties

### `wrappedValue`

``` swift
var wrappedValue: Value
```

### `publisher`

``` swift
var publisher: PublishablePublisher<Value>?
```

### `objectWillChange`

``` swift
var objectWillChange: ObservableObjectPublisher?
```
