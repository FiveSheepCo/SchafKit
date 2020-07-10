//  Copyright (c) 2020 Quintschaf GbR
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
#if canImport(TweenNacl)
import TweetNacl

public extension OKCryptography {
    /// Algorithm for secret-key authenticated encryption.
    class XSalsa20Poly1305SecretBoxAlgorithm {
        /// A key for the `XSalsa20Poly1305SecretBoxAlgorithm`.
        public struct Key {
            /// The private key.
            public let privateKey : Data
            
            /**
             Initializes a new key.
             
             - parameter privateKey: The private key. This data should be `crypto_secretbox_KEYBYTES` bytes long. The default is random data.
             */
            public init (privateKey: Data = Data(randomWith: Int(crypto_secretbox_KEYBYTES))) {
                self.privateKey = privateKey
            }
        }
        /// A nonce for the `XSalsa20Poly1305SecretBoxAlgorithm`.
        public struct Nonce {
            /// The nonce.
            public let nonce : Data
            
            /**
             Initializes a new nonce.
             
             - parameter nonce: The nonce. This data should be `crypto_secretbox_NONCEBYTES` bytes long. The default is random data.
             */
            public init (nonce: Data = Data(randomWith: Int(crypto_secretbox_NONCEBYTES))) {
                self.nonce = nonce
            }
        }
        
        /**
         Encrypts data.
         
         - Parameters:
             - data: The data to encrypt.
             - key: The key.
             - nonce: The nonce.
         */
        public static func encrypt(_ data : Data, with key : Data, nonce : Data) -> Data {
            let data = Data(count: Int(crypto_secretbox_ZEROBYTES)).appending(data)
            let dataSize = data.count
            var result = Data(count: dataSize)
            
            result.withUnsafeMutableBytes({ (resultPointer) -> Void in
                data.withUnsafeBytes({ (dataPointer) -> Void in
                    key.withUnsafeBytes({ (keyPointer) -> Void in
                        nonce.withUnsafeBytes({ (noncePointer) -> Void in
                            crypto_secretbox_xsalsa20poly1305_tweet(resultPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                    dataPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                    UInt64(dataSize),
                                                                    noncePointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                    keyPointer.baseAddress?.assumingMemoryBound(to: UInt8.self))
                        })
                    })
                })
            })
            
            return result
        }
        
        /**
         Decrypts data.
         
         - Parameters:
             - data: The data to encrypt.
             - key: The key.
             - nonce: The nonce.
         */
        public static func decrypt(_ data : Data, with key : Data, nonce : Data) -> Data? {
            let dataSize = data.count
            var result = Data(count: dataSize)
            
            let status = result.withUnsafeMutableBytes({ (resultPointer) -> Int32 in
                return data.withUnsafeBytes({ (dataPointer) -> Int32 in
                    return key.withUnsafeBytes({ (keyPointer) -> Int32 in
                        return nonce.withUnsafeBytes({ (noncePointer) -> Int32 in
                            return crypto_secretbox_xsalsa20poly1305_tweet_open(resultPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                                dataPointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                                UInt64(dataSize),
                                                                                noncePointer.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                                                                keyPointer.baseAddress?.assumingMemoryBound(to: UInt8.self))
                        })
                    })
                })
            })
            
            if status != 0 {
                return nil
            }
            
            return result.subdata(in: Int(crypto_secretbox_ZEROBYTES)..<result.count)
        }
        
        /**
         Encrypts data and appends the nonce to it.
         
         - Parameters:
             - data: The data to encrypt.
             - key: The key.
             - nonce: The nonce to use. The default is a randomly generated one.
         */
        public static func encryptWithRandomNonceAppended(_ data: Data, with key: Data, nonce: Nonce = Nonce()) -> Data {
            let nonceData = nonce.nonce
            
            return encrypt(data, with: key, nonce: nonceData).appending(nonceData)
        }
        
        /**
         Decrypts data emitted by the `encryptWithRandomNonceAppended(_:, with:)` method.
         
         - Parameters:
             - data: The data to decrypt.
             - privateKey: The private key.
         */
        public static func decryptWithNonceAppended(_ data: Data, with key: Data) -> Data? {
            let nonceStart = data.count-Int(crypto_stream_xsalsa20_NONCEBYTES)
            
            let nonce = data.subdata(in: nonceStart..<data.count)
            let data = data.subdata(in: 0..<nonceStart)
            
            return decrypt(data, with: key, nonce: nonce)
        }
    }
}
#endif
