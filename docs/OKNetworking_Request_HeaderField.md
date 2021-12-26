# SKNetworking.Request.HeaderField

Header field keys to use on a network request.

``` swift
enum HeaderField
```

## Inheritance

`ExpressibleByStringLiteral`, `Hashable`

## Nested Type Aliases

### `StringLiteralType`

``` swift
public typealias StringLiteralType = String
```

## Initializers

### `init(stringLiteral:)`

Returns a new `SKNetworking.Request.HeaderField` with the specified value.

``` swift
public init(stringLiteral value: StringLiteralType)
```

## Enumeration Cases

### `accept`

"Accept"

``` swift
case accept
```

### `acceptCharset`

"Accept-Charset"

``` swift
case acceptCharset
```

### `authorization`

"Authorization"

``` swift
case authorization
```

### `cacheControl`

"Cache-Control"

``` swift
case cacheControl
```

### `connection`

"Connection"

``` swift
case connection
```

### `cookie`

"Cookie"

``` swift
case cookie
```

### `contentMD5`

"Content-MD5"

``` swift
case contentMD5
```

### `contentType`

"Content-Type"

``` swift
case contentType
```

### `date`

"Date"

``` swift
case date
```

### `DNT`

"DNT"

``` swift
case DNT
```

### `expect`

"Expect"

``` swift
case expect
```

### `forwarded`

"Forwarded"

``` swift
case forwarded
```

### `from`

"From"

``` swift
case from
```

### `frontEndHttps`

"Front-End-Https"

``` swift
case frontEndHttps
```

### `host`

"Host"

``` swift
case host
```

### `ifMatch`

"If-Match"

``` swift
case ifMatch
```

### `ifModifiedSince`

"If-Modified-Since"

``` swift
case ifModifiedSince
```

### `ifNoneMatch`

"If-None-Match"

``` swift
case ifNoneMatch
```

### `ifRange`

"If-Range"

``` swift
case ifRange
```

### `ifUnmodifiedSince`

"If-Unmodified-Since"

``` swift
case ifUnmodifiedSince
```

### `maxForwards`

"Max-Forwards"

``` swift
case maxForwards
```

### `pragma`

"Pragma"

``` swift
case pragma
```

### `proxyAuthorization`

"Proxy-Authorization"

``` swift
case proxyAuthorization
```

### `proxyConnection`

"Proxy-Connection"

``` swift
case proxyConnection
```

### `referer`

"Referer"

``` swift
case referer
```

### `userAgent`

"User-Agent"

``` swift
case userAgent
```

### `upgrade`

"Upgrade"

``` swift
case upgrade
```

### `via`

"Via"

``` swift
case via
```

### `warning`

"Warning"

``` swift
case warning
```

### `xATTDeviceId`

"X-ATT-DeviceId"

``` swift
case xATTDeviceId
```

### `xCsrfToken`

"X-Csrf-Token"

``` swift
case xCsrfToken
```

### `xForwardedHost`

"X-Forwarded-Host"

``` swift
case xForwardedHost
```

### `xForwardedProto`

"X-Forwarded-Proto"

``` swift
case xForwardedProto
```

### `xHttpMethodOverride`

"X-Http-Method-Override"

``` swift
case xHttpMethodOverride
```

### `xUIDH`

"X-UIDH"

``` swift
case xUIDH
```

### `xWapProfile`

"X-Wap-Profile"

``` swift
case xWapProfile
```

### `custom`

A custom header field.

``` swift
case custom(value: String)
```

## Properties

### `name`

``` swift
var name: String
```

## Methods

### `==(lhs:rhs:)`

``` swift
public static func ==(lhs: HeaderField, rhs: HeaderField) -> Bool
```
