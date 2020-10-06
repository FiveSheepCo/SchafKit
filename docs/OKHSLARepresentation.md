# OKHSLARepresentation

A color representation containing representations of the `hue`, `saturation`, `brightness` and `alpha` values.

``` swift
public struct OKHSLARepresentation: Equatable
```

## Inheritance

`Equatable`

## Properties

### `hue`

``` swift
var hue: CGFloat
```

### `saturation`

``` swift
var saturation: CGFloat
```

### `brightness`

``` swift
var brightness: CGFloat
```

### `alpha`

``` swift
var alpha: CGFloat
```

### `color`

Initializes and returns a `UIColor` object using the specified `OKHSLARepresentation`.

``` swift
var color: UIColor
```

## Methods

### `==(left:right:)`

``` swift
public static func ==(left: OKHSLARepresentation, right: OKHSLARepresentation) -> Bool
```
