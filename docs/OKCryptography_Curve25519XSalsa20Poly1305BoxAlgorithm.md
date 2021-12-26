# SKCryptography.Curve25519XSalsa20Poly1305BoxAlgorithm

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Algorithm for public-key authenticated encryption.

``` swift
class Curve25519XSalsa20Poly1305BoxAlgorithm
```

</dd>
</dl>

## Methods

### `encrypt(_:with:publicKey:nonce:)`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Encrypts data.

``` swift
public static func encrypt(_ data: Data, with privateKey: Data, publicKey: Data, nonce: Data) -> Data
```

#### Parameters

  - data: The data to encrypt.
  - privateKey: The private key.
  - publicKey: The public key.
  - nonce: The nonce.

</dd>
</dl>

### `decrypt(_:with:publicKey:nonce:)`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Decrypts data.

``` swift
public static func decrypt(_ data: Data, with privateKey: Data, publicKey: Data, nonce: Data) -> Data?
```

#### Parameters

  - data: The data to decrypt.
  - privateKey: The private key.
  - publicKey: The public key.
  - nonce: The nonce.

</dd>
</dl>

### `encryptWithRandomNonceAndPublicKeyAppended(_:with:ownKeyPair:nonce:)`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Encrypts data and appends the nonce and public key to it.

``` swift
public static func encryptWithRandomNonceAndPublicKeyAppended(_ data: Data, with publicKey: Data, ownKeyPair: KeyPair, nonce: Nonce = Nonce()) -> Data
```

#### Parameters

  - data: The data to encrypt.
  - publicKey: The remote public key.
  - ownKeyPair: The local key pair.
  - nonce: The nonce to use. The default is a randomly generated one.

</dd>
</dl>

### `decryptWithNonceAndPublicKeyAppended(_:with:)`

<dl>
<dt><code>canImport(TweetNacl)</code></dt>
<dd>

Decrypts data emitted by the `encryptWithRandomNonceAndPublicKeyAppended(_:​, with:​, ownKeyPair:​)` method.

``` swift
public static func decryptWithNonceAndPublicKeyAppended(_ data: Data, with privateKey: Data) -> Data?
```

#### Parameters

  - data: The data to decrypt.
  - privateKey: The private key.

</dd>
</dl>
