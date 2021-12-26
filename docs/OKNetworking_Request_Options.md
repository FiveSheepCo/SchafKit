# SKNetworking.Request.Options

Options to use on a network request.

``` swift
enum Options
```

## Inheritance

[`SKOptions`](/SKOptions)

## Enumeration Cases

### `requestMethod`

Defines the request method to use. The default value is `.get`.

``` swift
case requestMethod(value: SKNetworking.Request.Method)
```

### `body`

Defines the request body.

``` swift
case body(value: SKNetworking.Request.Body)
```

### `headerFields`

Defines the header fields.

``` swift
case headerFields(value: [SKNetworking.Request.HeaderField : String])
```

### `authChallengeHandler`

Defines an auth challenge handler which handles authentication challenges when needed.

``` swift
case authChallengeHandler(value: SKNetworking.AuthChallengeBlock)
```

### `cachePolicy`

Defines the cache policy. The default value is `.useProtocolCachePolicy`.

``` swift
case cachePolicy(value: URLRequest.CachePolicy)
```

### `timeoutInterval`

Defines the timeout interval. The default value is `60`.

``` swift
case timeoutInterval(value: TimeInterval)
```
