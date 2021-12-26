# SKNetworking.Request.Body

The body to use on a network request.

``` swift
enum Body
```

> 

## Enumeration Cases

### `formData`

Defines a form data body.

``` swift
case formData(value: [String : String])
```

### `xWwwFormUrlencoded`

Defines a x-www-form-urlencoded body.

``` swift
case xWwwFormUrlencoded(value: [String : String])
```

### `raw`

Defines a raw body.

``` swift
case raw(value: String, type: String)
```

### `binary`

Defines a binary body.

``` swift
case binary(value: Data, type: String)
```

## Properties

### `body`

The body data.

``` swift
var body: Data?
```

### `type`

The body type, if it's defined.

``` swift
var type: String?
```
