# SKNetworking

A class helping to make web requests.

``` swift
public class SKNetworking
```

## Nested Type Aliases

### `AuthChallengeBlock`

A network authentication challenge block.

``` swift
public typealias AuthChallengeBlock = (_ challenge : URLAuthenticationChallenge, _ completionHandler:@escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) -> Void
```

> 

### `RequestCompletionBlock`

A network request completion block.

``` swift
public typealias RequestCompletionBlock = (_ result : Result<SKNetworking.RequestResult, Error>) -> Void
```

### `DownloadRequestUpdateBlock`

A network download request update block.

``` swift
public typealias DownloadRequestUpdateBlock = (_ bytesWritten : Int64, _ bytesExpectedToWrite : Int64) -> Void
```

### `DownloadRequestCompletionBlock`

A network download request completion block.

``` swift
public typealias DownloadRequestCompletionBlock = (_ result : Result<SKNetworking.DownloadResult, Error>) -> Void
```

## Methods

### `request(url:options:completion:)`

Makes a network request with the given url and options and calls the completion handler when finished.

``` swift
public class func request(url: String, options: SKOptionSet<SKNetworking.Request.Options> = [], completion: @escaping RequestCompletionBlock)
```

### `requestDownload(url:options:update:completion:)`

Makes a network download request with the given url and options and calls the completion handler when finished.

``` swift
public class func requestDownload(url: String, options: SKOptionSet<SKNetworking.Request.Options> = [], update: @escaping DownloadRequestUpdateBlock = {_,_ in }, completion: @escaping DownloadRequestCompletionBlock)
```
