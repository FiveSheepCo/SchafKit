# OKUnit

A class helping with the display of measurements in units, currently bytes and time.

``` swift
public class OKUnit
```

## Methods

### `getByteSizeString(from:useAbbreviation:locale:)`

Converts a byte size into a human readable string.

``` swift
public static func getByteSizeString(from byteSize: Int, useAbbreviation: Bool = true, locale: Locale = .autoupdatingCurrent) -> String
```

  - example: 1200 -\> "1.2 KB"

### `getBitSizeString(from:useAbbreviation:locale:)`

Converts a bit size into a human readable string.

``` swift
public static func getBitSizeString(from bitSize: Int, useAbbreviation: Bool = true, locale: Locale = .autoupdatingCurrent) -> String
```

  - example: 1200 -\> "1.2 Kbit"

### `getTimeString(from:useAbbreviation:locale:)`

Converts seconds into a human readable string.

``` swift
public static func getTimeString(from seconds: Double, useAbbreviation: Bool = true, locale: Locale = .autoupdatingCurrent) -> String
```

  - example: 1200 -\> "20 min"
