# SKStoreKitHelper

``` swift
public class SKStoreKitHelper
```

## Properties

### `shared`

``` swift
let shared
```

## Methods

### `requestInAppProduct(for:completionHandler:)`

``` swift
public func requestInAppProduct(for identifier: String, completionHandler: @escaping SKProductFetchCompletionHandler)
```

### `requestInAppProducts(for:completionHandler:)`

``` swift
public func requestInAppProducts(for identifiers: Set<String>, completionHandler: @escaping SKProductsFetchCompletionHandler)
```

### `purchase(product:completionHandler:)`

``` swift
public func purchase(product: SKProduct, completionHandler: @escaping SKPurchaseHandler)
```

### `restorePurchases(completionHandler:)`

``` swift
public func restorePurchases(completionHandler: @escaping SKPurchaseHandler)
```

### `isPurchased(identifier:)`

``` swift
public func isPurchased(identifier: String) -> Bool
```
