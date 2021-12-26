# SKJsonRepresentable

A JSON representable.

``` swift
public class SKJsonRepresentable: Sequence
```

## Inheritance

`Sequence`

## Initializers

### `init(object:)`

Returns a new `SKJsonRepresentable` with the given object.

``` swift
public init(object: Any?)
```

### `init(jsonRepresentation:)`

Returns a new `SKJsonRepresentable` with the given JSON representation.

``` swift
public convenience init(jsonRepresentation: Data?)
```

### `init(jsonRepresentation:)`

Returns a new `SKJsonRepresentable` with the given JSON representation.

``` swift
public convenience init(jsonRepresentation: String?)
```

## Properties

### `value`

The current value, if any.

``` swift
let value: Any?
```

### `exists`

Whether the current representable exists.

``` swift
var exists: Bool
```

### `jsonRepresentation`

The JSON representation.

``` swift
var jsonRepresentation: Data?
```

### `boolValue`

The `Bool` value.

``` swift
var boolValue: Bool?
```

### `stringValue`

The `String` value.

``` swift
var stringValue: String?
```

### `numberValue`

The `NSNumber` value.

``` swift
var numberValue: NSNumber?
```

### `intValue`

The `Int` value.

``` swift
var intValue: Int?
```

### `doubleValue`

The `Double` value.

``` swift
var doubleValue: Double?
```

### `jsonArrayValue`

The `Array` value.

``` swift
var jsonArrayValue: [SKJsonRepresentable]?
```

### `arrayValue`

The `Array` value.

``` swift
var arrayValue: [Any]?
```

### `dictionaryValue`

The `Dictionary` value.

``` swift
var dictionaryValue: [String : Any]?
```

## Methods

### `makeIterator()`

``` swift
public func makeIterator() -> IndexingIterator<[SKJsonRepresentable]>
```
