# SKRegexMatch

A regular expression match.

``` swift
public struct SKRegexMatch
```

## Properties

### `range`

The range of the string that was captured.

``` swift
let range: NSRange
```

### `captureGroupRanges`

The ranges of the strings that were captured for the capture groups.

``` swift
let captureGroupRanges: [NSRange]
```

### `result`

The string that was captured.

``` swift
var result: String
```

### `captureGroups`

The strings that were captured for the capture groups.

``` swift
var captureGroups: [String?]
```
