# OKDispatchHelper

A dispatch helper.

``` swift
public class OKDispatchHelper
```

## Methods

### `dispatch(on:sync:block:)`

Dispatches a block.

``` swift
public class func dispatch(on queue: DispatchQueue, sync: Bool = false, block: @escaping OKBlock)
```

#### Parameters

  - sync: Whether to dispatch the queue synchronously.
  - queue: The queue onto which to dispatch the block.
  - block: The block to dispatch.

### `dispatchOnMainQueue(sync:block:)`

Dispatches a block onto the main queue.

``` swift
public class func dispatchOnMainQueue(sync: Bool = true, block: @escaping OKBlock)
```

#### Parameters

  - sync: Whether to dispatch the block synchronously.
  - block: The block to dispatch.

### `dispatchUserInitiatedTask(sync:block:)`

Dispatches a block onto the global `userInitiated` queue.

``` swift
public class func dispatchUserInitiatedTask(sync: Bool = false, block: @escaping OKBlock)
```

#### Parameters

  - sync: Whether to dispatch the block synchronously.
  - block: The block to dispatch.

### `dispatchUtilityTask(sync:block:)`

Dispatches a block onto the global `utility` queue.

``` swift
public class func dispatchUtilityTask(sync: Bool = false, block: @escaping OKBlock)
```

#### Parameters

  - sync: Whether to dispatch the block synchronously.
  - block: The block to dispatch.

### `dispatchBackgroundTask(sync:block:)`

Dispatches a block onto the global `background` queue.

``` swift
public class func dispatchBackgroundTask(sync: Bool = false, block: @escaping OKBlock)
```

#### Parameters

  - sync: Whether to dispatch the block synchronously.
  - block: The block to dispatch.
