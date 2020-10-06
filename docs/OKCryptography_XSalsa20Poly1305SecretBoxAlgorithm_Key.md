# OKCryptography.XSalsa20Poly1305SecretBoxAlgorithm.Key

<dl>
<dt><code>canImport(TweenNacl)</code></dt>
<dd>

A key for the `XSalsa20Poly1305SecretBoxAlgorithm`.

``` swift
public struct Key
```

</dd>
</dl>

## Initializers

### `init(privateKey:)`

<dl>
<dt><code>canImport(TweenNacl)</code></dt>
<dd>

Initializes a new key.

``` swift
public init(privateKey: Data = Data(randomWith: Int(crypto_secretbox_KEYBYTES)))
```

#### Parameters

  - privateKey: The private key. This data should be `crypto_secretbox_KEYBYTES` bytes long. The default is random data.

</dd>
</dl>

## Properties

### `privateKey`

<dl>
<dt><code>canImport(TweenNacl)</code></dt>
<dd>

The private key.

``` swift
let privateKey: Data
```

</dd>
</dl>
