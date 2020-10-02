# OKDirectory

A dictionary representation.

``` swift
public class OKDirectory: OKFileSystemItem
```

## Inheritance

[`OKFileSystemItem`](/OKFileSystemItem)

## Initializers

### `init(path:createIfNonexistant:)`

Returns a new `OKDirectory` with the specified path.

``` swift
public init(path: String, createIfNonexistant: Bool = false)
```

#### Parameters

  - createIfNonexistant: Whether a directory should be created (with intermediate directories) at that path if it doesn't already exist.

### `init(url:createIfNonexistant:)`

Returns a new `OKDirectory` with the specified url.

``` swift
public convenience init(url: URL, createIfNonexistant: Bool = false)
```

## Properties

### `bundle`

The Bundle directory.

``` swift
let bundle
```

### `library`

The `Library` directory.

``` swift
let library
```

### `applicationSupport`

The `Library/ApplicationSupport` directory.

``` swift
let applicationSupport
```

### `caches`

The `Library/Caches` directory.

``` swift
let caches
```

### `documents`

The `Documents` directory.

``` swift
let documents
```

### `inbox`

The `Documents/Inbox` directory.

``` swift
let inbox
```

### `contents`

The contents of the receiver as strings.

``` swift
var contents: [String]
```

## Methods

### `appGroupDirectory(forGroupNamed:)`

Returns the directory for the specified app group, if it exists.

``` swift
public static func appGroupDirectory(forGroupNamed name: String) -> OKDirectory?
```

### `create()`

Creates the receiver in the file system.

``` swift
public func create() -> Bool
```

### `getData(at:)`

Returns the contents of the file at the given path, if it exists.

``` swift
public func getData(at path: String) -> Data?
```

### `save(data:at:)`

Saves the data to the path.

``` swift
public func save(data: Data, at path: String) -> Bool
```

### `delete(at:)`

Deletes the file at the given path, if it exists.

``` swift
public func delete(at path: String)
```

### `directoryByAppending(path:createIfNonexistant:)`

Returns a new `OKDirectory` by appending the path to the receiver's path.

``` swift
public func directoryByAppending(path: String, createIfNonexistant: Bool = false) -> OKDirectory
```
