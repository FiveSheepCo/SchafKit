# PublishablePublisher

A publisher for properties marked with the `@Published` attribute.

``` swift
public struct PublishablePublisher<Value>: Combine.Publisher
```

## Inheritance

`Combine.Publisher`

## Nested Type Aliases

### `Output`

``` swift
public typealias Output = Value
```

### `Failure`

``` swift
public typealias Failure = Never
```

## Initializers

### `init(_:)`

``` swift
public init(_ output: Output)
```

## Properties

### `subject`

``` swift
let subject: Combine.CurrentValueSubject<Value, Never>
```

## Methods

### `receive(subscriber:)`

``` swift
public func receive<Downstream: Subscriber>(subscriber: Downstream) where Downstream.Input == Value, Downstream.Failure == Never
```
