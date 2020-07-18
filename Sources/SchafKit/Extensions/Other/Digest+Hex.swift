//
//  Digest+Hex.swift
//  
//
//  Created by Marco Quinten on 18.07.20.
//

#if canImport(CryptoKit)
import Foundation
import CryptoKit

public extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}
#endif
