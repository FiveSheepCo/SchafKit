# SKOptionSet

The `SKOptionSet` class implements a way to use Swift Enumerations as options. For this to work, the enum has to adapt to the `OKOption` protocol. A `SKOptionSet` can only contain one instance of a particular Element at a time. Enumerations with an associated values are equal, even if the associated values are not.

``` swift
public class SKOptionSet<Element>: ExpressibleByArrayLiteral, Sequence where Element: SKOptions
```

> 

## Inheritance

`ExpressibleByArrayLiteral`, `Sequence`

## Initializers

### `init(arrayLiteral:)`

Returns an initialized instance of SKOptionSet, containing the given elements.

``` swift
public required init(arrayLiteral elements: Element)
```

## Methods

### `makeIterator()`

``` swift
public func makeIterator() -> Array<Element>.Iterator
```

### `+(left:right:)`

Returns a `SKOptionSet` containing the options of both given sets.

``` swift
public static func +(left: SKOptionSet<Element>, right: SKOptionSet<Element>) -> SKOptionSet<Element>
```

> 

### `+(left:right:)`

Returns a `SKOptionSet` containing the options of the given set and the additional element.

``` swift
public static func +(left: SKOptionSet<Element>, right: Element) -> SKOptionSet<Element>
```

> 

### `+=(left:right:)`

Adds the elements of the `SKOptionSet` on the right to the left `SKOptionSet`.

``` swift
public static func +=(left: inout SKOptionSet<Element>, right: SKOptionSet<Element>)
```

> 

### `+=(left:right:)`

Adds the element on the right to the left `SKOptionSet`.

``` swift
public static func +=(left: inout SKOptionSet<Element>, right: Element)
```

> 
