# OKCryptography.XSalsa20Poly1305SecretBoxAlgorithm

<dl>
<dt><code>canImport(TweenNacl)</code></dt>
<dd>

Algorithm for secret-key authenticated encryption.

``` swift
class XSalsa20Poly1305SecretBoxAlgorithm
```

</dd>
</dl>

## Methods

### `encrypt(_:with:nonce:)`

<dl>
<dt><code>canImport(TweenNacl)</code></dt>
<dd>

Encrypts data.

``` swift
public static func encrypt(_ data: Data, with key: Data, nonce: Data) -> Data
```

#### Parameters

  - data: The data to encrypt.
  - key: The key.
  - nonce: The nonce.

</dd>
</dl>

### `decrypt(_:with:nonce:)`

<dl>
<dt><code>canImport(TweenNacl)</code></dt>
<dd>

Decrypts data.

``` swift
public static func decrypt(_ data: Data, with key: Data, nonce: Data) -> Data?
```

#### Parameters

  - data: The data to encrypt.
  - key: The key.
  - nonce: The nonce.

</dd>
</dl>

### `encryptWithRandomNonceAppended(_:with:nonce:)`

<dl>
<dt><code>canImport(TweenNacl)</code></dt>
<dd>

Encrypts data and appends the nonce to it.

``` swift
public static func encryptWithRandomNonceAppended(_ data: Data, with key: Data, nonce: Nonce = Nonce()) -> Data
```

#### Parameters

  - data: The data to encrypt.
  - key: The key.
  - nonce: The nonce to use. The default is a randomly generated one.

</dd>
</dl>

### `decryptWithNonceAppended(_:with:)`

<dl>
<dt><code>canImport(TweenNacl)</code></dt>
<dd>

Decrypts data emitted by the `encryptWithRandomNonceAppended(_:​, with:​)` method.

``` swift
public static func decryptWithNonceAppended(_ data: Data, with key: Data) -> Data?
```

#### Parameters

  - data: The data to decrypt.
  - privateKey: The private key.

</dd>
</dl>
