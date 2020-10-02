# OKRGBARepresentation

A color representation containing representations of the `red`, `blue`, `green` and `alpha` values.

``` swift
public struct OKRGBARepresentation: Equatable
```

## Inheritance

`Equatable`

## Initializers

### `init(red:green:blue:alpha:)`

Initializes and returns a `OKRGBARepresentation` object.

``` swift
public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1)
```

### `init(bitRepresentation:)`

Initializes and returns a `OKRGBARepresentation` object.

``` swift
public init(bitRepresentation: OK8BitRGBARepresentation)
```

## Properties

### `red`

``` swift
let red: CGFloat
```

### `green`

``` swift
let green: CGFloat
```

### `blue`

``` swift
let blue: CGFloat
```

### `alpha`

``` swift
let alpha: CGFloat
```

### `color`

Initializes and returns a `UIColor` object using the specified `OKRGBARepresentation`.

``` swift
var color: UIColor
```

## Methods

### `==(left:right:)`

``` swift
public static func ==(left: OKRGBARepresentation, right: OKRGBARepresentation) -> Bool
```
