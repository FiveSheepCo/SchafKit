# SKCryptography.Curve25519XSalsa20Poly1305BoxAlgorithm.KeyPair

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

A key pair for the `Curve25519XSalsa20Poly1305BoxAlgorithm`.

``` swift
public struct KeyPair
```

</dd>
</dl>

## Initializers

### `init(privateKey:)`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Initializes a new key pair.

``` swift
public init(privateKey: Data = Data(randomWith: Int(crypto_box_SECRETKEYBYTES)))
```

#### Parameters

  - privateKey: The private key. This data should be `crypto_box_SECRETKEYBYTES` bytes long. The default is random data.

</dd>
</dl>

### `init(privateKey:publicKey:)`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Initializes a new key pair with the given keys. These are used as-is, without any modification.

``` swift
public init(privateKey: Data, publicKey: Data)
```

</dd>
</dl>

## Properties

### `publicKey`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

The public key.

``` swift
let publicKey: Data
```

</dd>
</dl>

### `privateKey`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

The private key.

``` swift
let privateKey: Data
```

</dd>
</dl>
