# PresentationLink

Sheet presentation button analogue to NavigationLink.

``` swift
public struct PresentationLink<Label, Destination>: View where Label: View, Destination: View
```

## Inheritance

`View`

## Initializers

### `init(destination:label:withNavigationView:)`

``` swift
public init(destination: Destination, label: @escaping () -> Label, withNavigationView: Bool = true)
```

## Properties

### `body`

``` swift
var body: some View
```
