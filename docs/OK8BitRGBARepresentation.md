# OK8BitRGBARepresentation

A color representation containing 8-bit representations of the `red`, `blue`, `green` and `alpha` values.

``` swift
public struct OK8BitRGBARepresentation: Equatable
```

## Inheritance

`Equatable`

## Initializers

### `init(red:green:blue:alpha:)`

Initializes and returns a `OK8BitRGBARepresentation` object.

``` swift
public init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8 = 255)
```

### `init(representation:)`

Initializes and returns a `OK8BitRGBARepresentation` object.

``` swift
public init(representation: OKRGBARepresentation)
```

## Properties

### `red`

``` swift
let red: UInt8
```

### `green`

``` swift
let green: UInt8
```

### `blue`

``` swift
let blue: UInt8
```

### `alpha`

``` swift
let alpha: UInt8
```

### `color`

Initializes and returns a `UIColor` object using the specified `OK8BitRGBARepresentation`.

``` swift
var color: UIColor
```

## Methods

### `==(left:right:)`

``` swift
public static func ==(left: OK8BitRGBARepresentation, right: OK8BitRGBARepresentation) -> Bool
```
