# OKSubtileNotification

<dl>
<dt><code>os(iOS)</code></dt>
<dd>

An object representing a subtile notification covering the status bar for a fixed duration.

``` swift
public class OKSubtileNotification
```

> 

</dd>
</dl>

## Initializers

### `init(title:)`

<dl>
<dt><code>os(iOS)</code></dt>
<dd>

Returns a new `OKSubtileNotification`.

``` swift
public convenience init(title: String)
```

#### Parameters

  - title: The title to show on the notification.
  - duration: The duration the notification should last before disappearing. The default value is 1.

</dd>
</dl>

### `init(title:duration:)`

<dl>
<dt><code>os(iOS)</code></dt>
<dd>

Returns a new `OKSubtileNotification`.

``` swift
public init(title: String, duration: TimeInterval)
```

#### Parameters

  - title: The title to show on the notification.
  - duration: The duration the notification should last before disappearing. The default value is 1.

</dd>
</dl>

## Methods

### `show()`

<dl>
<dt><code>os(iOS)</code></dt>
<dd>

Shows the notification.

``` swift
public func show()
```

</dd>
</dl>

### `show(with:)`

<dl>
<dt><code>os(iOS)</code></dt>
<dd>

Shows a notification.

``` swift
public static func show(with title: String)
```

#### Parameters

  - title: The title to show on the notification.
  - duration: The duration the notification should last before disappearing. The default value is 1.

</dd>
</dl>

### `show(with:duration:)`

<dl>
<dt><code>os(iOS)</code></dt>
<dd>

Shows a notification.

``` swift
public static func show(with title: String, duration: TimeInterval)
```

#### Parameters

  - title: The title to show on the notification.
  - duration: The duration the notification should last before disappearing. The default value is 1.

</dd>
</dl>
