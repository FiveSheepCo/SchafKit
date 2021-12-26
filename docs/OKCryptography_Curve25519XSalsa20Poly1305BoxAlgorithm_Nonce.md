# SKCryptography.Curve25519XSalsa20Poly1305BoxAlgorithm.Nonce

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

A nonce for the `Curve25519XSalsa20Poly1305BoxAlgorithm`.

``` swift
public struct Nonce
```

</dd>
</dl>

## Initializers

### `init(nonce:)`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Initializes a new nonce.

``` swift
public init(nonce: Data = Data(randomWith: Int(crypto_box_NONCEBYTES)))
```

#### Parameters

  - nonce: The nonce. This data should be `crypto_box_NONCEBYTES` bytes long. The default is random data.

</dd>
</dl>

## Properties

### `nonce`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

The nonce.

``` swift
let nonce: Data
```

</dd>
</dl>
