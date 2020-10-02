# EmojiTextFieldView

<dl>
<dt><code>os(iOS)</code></dt>
<dd>

``` swift
public struct EmojiTextFieldView: UIViewRepresentable
```

</dd>
</dl>

## Inheritance

`UIViewRepresentable`

## Initializers

### `init(text:)`

<dl>
<dt><code>os(iOS)</code></dt>
<dd>

``` swift
public init(text: Binding<String>)
```

</dd>
</dl>

## Methods

### `makeUIView(context:)`

<dl>
<dt><code>os(iOS)</code></dt>
<dd>

``` swift
public func makeUIView(context: Context) -> EmojiTextField
```

</dd>
</dl>

### `updateUIView(_:context:)`

<dl>
<dt><code>os(iOS)</code></dt>
<dd>

``` swift
public func updateUIView(_ uiView: EmojiTextField, context: Context)
```

</dd>
</dl>

### `makeCoordinator()`

<dl>
<dt><code>os(iOS)</code></dt>
<dd>

``` swift
public func makeCoordinator() -> Coordinator
```

</dd>
</dl>
