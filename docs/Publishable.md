# Publishable

``` swift
public protocol Publishable
```

## Requirements

### wrappedValue

``` swift
var wrappedValue: Value
```

### publisher

``` swift
var publisher: PublishablePublisher<Value>?
```

### objectWillChange

``` swift
var objectWillChange: ObservableObjectPublisher?
```
