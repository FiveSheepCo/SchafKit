# OrderedDictionary

``` swift
public struct OrderedDictionary<Key: Equatable, Value>: Sequence
```

## Inheritance

`Sequence`

## Initializers

### `init()`

``` swift
public init()
```

## Properties

### `count`

``` swift
var count: Int
```

## Methods

### `makeIterator()`

``` swift
public func makeIterator() -> IndexingIterator<[(Key, Value)]>
```
