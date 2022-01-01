import Foundation
#if canImport(TweetNacl)
import TweetNacl

public extension SKCryptography {
    /// Algorithm for public-key authenticated encryption.
    class Curve25519XSalsa20Poly1305BoxAlgorithm {
        /// A key pair for the `Curve25519XSalsa20Poly1305BoxAlgorithm`.
        public struct KeyPair {
            /// The public key.
            public let publicKey : Data
            /// The private key.
            public let privateKey : Data
            
            /**
             Initializes a new key pair.
             
             - parameter privateKey: The private key. This data should be `crypto_box_SECRETKEYBYTES` bytes long. The default is random data.
             */
            public init (privateKey: Data = Data(randomWith: Int(crypto_box_SECRETKEYBYTES))) {
                var pk = Data(count: Int(crypto_box_PUBLICKEYBYTES))
                var sk = privateKey
                
                pk.withUnsafeMutableBytes({ (pkPointer) -> Void in
                    sk.withUnsafeMutableBytes({ (skPointer) -> Void in
                        crypto_box_curve25519xsalsa20poly1305_tweet_keypair(pkPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                            skPointer.baseAddress?.assumingMemoryBound(to: UInt8.self))
                    })
                })
                
                self.publicKey = pk
                self.privateKey = sk
            }
            
            /**
             Initializes a new key pair with the given keys. These are used as-is, without any modification.
             */
            public init (privateKey: Data, publicKey: Data) {
                self.privateKey = privateKey
                self.publicKey = publicKey
            }
        }
        /// A nonce for the `Curve25519XSalsa20Poly1305BoxAlgorithm`.
        public struct Nonce {
            /// The nonce.
            public let nonce : Data
            
            /**
             Initializes a new nonce.
             
             - parameter nonce: The nonce. This data should be `crypto_box_NONCEBYTES` bytes long. The default is random data.
             */
            public init (nonce: Data = Data(randomWith: Int(crypto_box_NONCEBYTES))) {
                self.nonce = nonce
            }
        }
        
        /**
         Encrypts data.
         
         - Parameters:
             - data: The data to encrypt.
             - privateKey: The private key.
             - publicKey: The public key.
             - nonce: The nonce.
         */
        public static func encrypt(_ data : Data, with privateKey : Data, publicKey : Data, nonce : Data) -> Data {
            let data = Data(count: Int(crypto_box_ZEROBYTES)).appending(data)
            let dataSize = data.count
            var result = Data(count: dataSize)
            
            result.withUnsafeMutableBytes({ (resultPointer ) -> Void in
                data.withUnsafeBytes({ (dataPointer) -> Void in
                    nonce.withUnsafeBytes({ (noncePointer) -> Void in
                        privateKey.withUnsafeBytes({ (privateKeyPointer) -> Void in
                            publicKey.withUnsafeBytes({ (publicKeyPointer) -> Void in
                                crypto_box_curve25519xsalsa20poly1305_tweet(resultPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                            dataPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                            UInt64(dataSize),
                                                                            noncePointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                            publicKeyPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                            privateKeyPointer.baseAddress?.assumingMemoryBound(to: UInt8.self))
                            })
                        })
                    })
                })
            })
            
            return result
        }
        
        /**
         Decrypts data.
         
         - Parameters:
             - data: The data to decrypt.
             - privateKey: The private key.
             - publicKey: The public key.
             - nonce: The nonce.
         */
        public static func decrypt(_ data : Data, with privateKey : Data, publicKey : Data, nonce : Data) -> Data? {
            let dataSize = data.count
            var result = Data(count: dataSize)
            
            let status = result.withUnsafeMutableBytes({ (resultPointer ) -> Int32 in
                return data.withUnsafeBytes({ (dataPointer) -> Int32 in
                    return nonce.withUnsafeBytes({ (noncePointer) -> Int32 in
                        return privateKey.withUnsafeBytes({ (privateKeyPointer) -> Int32 in
                            return publicKey.withUnsafeBytes({ (publicKeyPointer) -> Int32 in
                                return crypto_box_curve25519xsalsa20poly1305_tweet_open(resultPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                                        dataPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                                        UInt64(dataSize),
                                                                                        noncePointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                                        publicKeyPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                                        privateKeyPointer.baseAddress?.assumingMemoryBound(to: UInt8.self))
                            })
                        })
                    })
                })
            })
            
            if status != 0 {
                return nil
            }
            
            return result.subdata(in: Int(crypto_box_ZEROBYTES)..<result.count)
        }
        
        /**
         Encrypts data and appends the nonce and public key to it.
         
         - Parameters:
             - data: The data to encrypt.
             - publicKey: The remote public key.
             - ownKeyPair: The local key pair.
             - nonce: The nonce to use. The default is a randomly generated one.
         */
        public static func encryptWithRandomNonceAndPublicKeyAppended(_ data : Data,
                                                                       with publicKey : Data,
                                                                       ownKeyPair : KeyPair,
                                                                       nonce: Nonce = Nonce()) -> Data {
            let nonceData = nonce.nonce
            
            return encrypt(data, with: ownKeyPair.privateKey, publicKey: publicKey, nonce: nonceData).appending(nonceData).appending(ownKeyPair.publicKey)
        }
        
        /**
         Decrypts data emitted by the `encryptWithRandomNonceAndPublicKeyAppended(_:, with:, ownKeyPair:)` method.
         
         - Parameters:
             - data: The data to decrypt.
             - privateKey: The private key.
         */
        public static func decryptWithNonceAndPublicKeyAppended(_ data : Data, with privateKey : Data) -> Data? {
            let publicKeyStart = data.count-Int(crypto_box_PUBLICKEYBYTES)
            let nonceStart = publicKeyStart-Int(crypto_box_NONCEBYTES)
            
            let publicKey = data.subdata(in: publicKeyStart..<data.count)
            let nonce = data.subdata(in: nonceStart..<publicKeyStart)
            let data = data.subdata(in: 0..<nonceStart)
            
            return decrypt(data, with: privateKey, publicKey: publicKey, nonce: nonce)
        }
    }
}
#endif
