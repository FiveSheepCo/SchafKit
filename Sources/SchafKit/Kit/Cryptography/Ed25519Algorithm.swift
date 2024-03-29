import Foundation
#if canImport(TweetNacl)
import TweetNacl

public extension SKCryptography {
    /// Algorithm for public-key signatures.
    class Ed25519Algorithm {
        /// A key pair for the `Ed25519Algorithm`.
        public struct KeyPair {
            /// The public key.
            public let publicKey : Data
            /// The private key.
            public let privateKey : Data
            
            /**
             Initializes a new key pair.
             
             - parameter privateKey: The private key. This data should be `crypto_sign_SECRETKEYBYTES` bytes long. The default is random data.
             */
            public init (privateKey: Data = Data(randomWith: Int(crypto_sign_SECRETKEYBYTES))) {
                var pk = Data(count: Int(crypto_sign_PUBLICKEYBYTES))
                var sk = privateKey
                
                _ = pk.withUnsafeMutableBytes({ (pkPointer) -> Int32 in
                    return sk.withUnsafeMutableBytes({ (skPointer) -> Int32 in
                        return crypto_sign_ed25519_tweet_keypair(pkPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                 skPointer.baseAddress?.assumingMemoryBound(to: UInt8.self))
                    })
                })
                
                self.publicKey = pk
                self.privateKey = sk
            }
        }
        
        /**
         Signs data.
         
         - Parameters:
             - data: The data to sign.
             - privateKey: The private key.
         */
        public static func sign(_ data : Data, with privateKey : Data) -> Data {
            let dataLength = data.count
            var signedData = Data(count: Int(crypto_sign_BYTES) + dataLength)
            
            let smlen = UnsafeMutablePointer<UInt64>.allocate(capacity: 1)
            
            signedData.withUnsafeMutableBytes({ (signedDataPointer) -> Void in
                data.withUnsafeBytes({ (dataPointer) -> Void in
                    privateKey.withUnsafeBytes({ (privateKeyPointer) -> Void in
                        crypto_sign_ed25519_tweet(signedDataPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                  smlen,
                                                  dataPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                  UInt64(dataLength),
                                                  privateKeyPointer.baseAddress?.assumingMemoryBound(to: UInt8.self))
                    })
                })
            })
            
            return signedData
        }
        
        /**
         Opens data.
         
         - Parameters:
             - data: The data to open.
             - publicKey: The public key.
         */
        public static func open(_ signedData : Data, with publicKey : Data) -> Data? {
            var result = Data(count: signedData.count)
            let smlen = UnsafeMutablePointer<UInt64>.allocate(capacity: 1)
            
            let status = result.withUnsafeMutableBytes({ (resultPointer) -> Int32 in
                return signedData.withUnsafeBytes({ (signedDataPointer) -> Int32 in
                    return publicKey.withUnsafeBytes({ (publicKeyPointer) -> Int32 in
                        return crypto_sign_ed25519_tweet_open(resultPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                              smlen,
                                                              signedDataPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                              UInt64(signedData.count),
                                                              publicKeyPointer.baseAddress?.assumingMemoryBound(to: UInt8.self))
                    })
                })
            })
            
            if status != 0 {
                return nil
            }
            return result.subdata(in: 0..<Int(smlen.pointee))
        }
        
        /**
         Validates data. Returns true if the data is valid.
         
         - Parameters:
             - signedData: The data to validate.
             - publicKey: The public key.
         */
        public static func validate(signedData : Data, publicKey : Data) -> Bool {
            return open(signedData, with: publicKey) != nil
        }
    }
}
#endif
