# OKOptionSet

The `OKOptionSet` class implements a way to use Swift Enumerations as options. For this to work, the enum has to adapt to the `OKOption` protocol. A `OKOptionSet` can only contain one instance of a particular Element at a time. Enumerations with an associated values are equal, even if the associated values are not.

``` swift
public class OKOptionSet<Element>: ExpressibleByArrayLiteral, Sequence where Element: OKOptions
```

> 

## Inheritance

`ExpressibleByArrayLiteral`, `Sequence`

## Initializers

### `init(arrayLiteral:)`

Returns an initialized instance of OKOptionSet, containing the given elements.

``` swift
public required init(arrayLiteral elements: Element)
```

## Methods

### `makeIterator()`

``` swift
public func makeIterator() -> Array<Element>.Iterator
```

### `+(left:right:)`

Returns a `OKOptionSet` containing the options of both given sets.

``` swift
public static func +(left: OKOptionSet<Element>, right: OKOptionSet<Element>) -> OKOptionSet<Element>
```

> 

### `+(left:right:)`

Returns a `OKOptionSet` containing the options of the given set and the additional element.

``` swift
public static func +(left: OKOptionSet<Element>, right: Element) -> OKOptionSet<Element>
```

> 

### `+=(left:right:)`

Adds the elements of the `OKOptionSet` on the right to the left `OKOptionSet`.

``` swift
public static func +=(left: inout OKOptionSet<Element>, right: OKOptionSet<Element>)
```

> 

### `+=(left:right:)`

Adds the element on the right to the left `OKOptionSet`.

``` swift
public static func +=(left: inout OKOptionSet<Element>, right: Element)
```

> 
