# OKCryptography.Ed25519Algorithm.KeyPair

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

A key pair for the `Ed25519Algorithm`.

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
public init(privateKey: Data = Data(randomWith: Int(crypto_sign_SECRETKEYBYTES)))
```

#### Parameters

  - privateKey: The private key. This data should be `crypto_sign_SECRETKEYBYTES` bytes long. The default is random data.

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
