# SKKeychain

``` swift
public class SKKeychain
```

## Methods

### `set(password:for:)`

Sets a specified value for a key id and returns whether the operation was successful.

``` swift
public static func set(password: String, for id: String) -> Bool
```

### `getPassword(for:)`

Gets a specified value for a key id and returns it if successful.

``` swift
public static func getPassword(for id: String) -> String?
```
