# SKCryptography.Ed25519Algorithm

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Algorithm for public-key signatures.

``` swift
class Ed25519Algorithm
```

</dd>
</dl>

## Methods

### `sign(_:with:)`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Signs data.

``` swift
public static func sign(_ data: Data, with privateKey: Data) -> Data
```

#### Parameters

  - data: The data to sign.
  - privateKey: The private key.

</dd>
</dl>

### `open(_:with:)`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Opens data.

``` swift
public static func open(_ signedData: Data, with publicKey: Data) -> Data?
```

#### Parameters

  - data: The data to open.
  - publicKey: The public key.

</dd>
</dl>

### `validate(signedData:publicKey:)`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Validates data. Returns true if the data is valid.

``` swift
public static func validate(signedData: Data, publicKey: Data) -> Bool
```

#### Parameters

  - signedData: The data to validate.
  - publicKey: The public key.

</dd>
</dl>
