# SKNetworking.Endpoint

A class acting as a proxy to make network requests to a given endpoint.

``` swift
public class Endpoint
```

## Initializers

### `init(url:baseOptions:)`

Returns a new `SKNetworking.Endpoint`.

``` swift
public init(url: String, baseOptions: SKOptionSet<SKNetworking.Request.Options> = [])
```

> 

## Properties

### `baseURL`

The base URL.

``` swift
let baseURL: String
```

### `baseOptions`

The base options.

``` swift
let baseOptions: SKOptionSet<SKNetworking.Request.Options>
```

> 

## Methods

### `request(path:options:completion:)`

Makes a network request with the given path appended to the responders base url and options and calls the completion handler when finished.

``` swift
public func request(path: String, options: SKOptionSet<SKNetworking.Request.Options> = [], completion: @escaping RequestCompletionBlock)
```

### `endpointByAppending(pathComponent:)`

Returns a `SKNetworking.Endpoint` by appending the given path component to the base url of the responder.

``` swift
public func endpointByAppending(pathComponent: String) -> Endpoint
```
