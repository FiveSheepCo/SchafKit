//  Copyright (c) 2015 - 2019 Jann Schafranek
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

public extension OKNetworking.Request {
    /// Header field keys to use on a network request.
    enum HeaderField : Hashable, ExpressibleByStringLiteral {
        public typealias StringLiteralType = String
        
        /// Returns a new `OKNetworking.Request.HeaderField` with the specified value.
        public init (stringLiteral value : StringLiteralType) {
            self = .custom(value: value)
        }
        
        /// "Accept"
        case accept
        
        /// "Accept-Charset"
        case acceptCharset
        
        /// "Authorization"
        case authorization
        
        /// "Cache-Control"
        case cacheControl
        
        /// "Connection"
        case connection
        
        /// "Cookie"
        case cookie
        
        /// "Content-MD5"
        case contentMD5
        
        /// "Content-Type"
        case contentType
        
        /// "Date"
        case date
        
        /// "DNT"
        case DNT
        
        /// "Expect"
        case expect
        
        /// "Forwarded"
        case forwarded
        
        /// "From"
        case from
        
        /// "Front-End-Https"
        case frontEndHttps
        
        /// "Host"
        case host
        
        /// "If-Match"
        case ifMatch
        
        /// "If-Modified-Since"
        case ifModifiedSince
        
        /// "If-None-Match"
        case ifNoneMatch
        
        /// "If-Range"
        case ifRange
        
        /// "If-Unmodified-Since"
        case ifUnmodifiedSince
        
        /// "Max-Forwards"
        case maxForwards
        
        /// "Pragma"
        case pragma
        
        /// "Proxy-Authorization"
        case proxyAuthorization
        
        /// "Proxy-Connection"
        case proxyConnection
        
        /// "Referer"
        case referer
        
        /// "User-Agent"
        case userAgent
        
        /// "Upgrade"
        case upgrade
        
        /// "Via"
        case via
        
        /// "Warning"
        case warning
        
        /// "X-ATT-DeviceId"
        case xATTDeviceId
        
        /// "X-Csrf-Token"
        case xCsrfToken
        
        /// "X-Forwarded-Host"
        case xForwardedHost
        
        /// "X-Forwarded-Proto"
        case xForwardedProto
        
        /// "X-Http-Method-Override"
        case xHttpMethodOverride
        
        /// "X-UIDH"
        case xUIDH
        
        /// "X-Wap-Profile"
        case xWapProfile
        
        /// A custom header field.
        case custom(value : String)
        
        
        public var name : String {
            switch self {
            case .accept:
                return "Accept"
            case .acceptCharset:
                return "Accept-Charset"
            case .authorization:
                return "Authorization"
            case .cacheControl:
                return "Cache-Control"
            case .connection:
                return "Connection"
            case .cookie:
                return "Cookie"
            case .contentMD5:
                return "Content-MD5"
            case .contentType:
                return "Content-Type"
            case .date:
                return "Date"
            case .DNT:
                return "DNT"
            case .expect:
                return "Expect"
            case .forwarded:
                return "Forwarded"
            case .from:
                return "From"
            case .frontEndHttps:
                return "Front-End-Https"
            case .host:
                return "Host"
            case .ifMatch:
                return "If-Match"
            case .ifModifiedSince:
                return "If-Modified-Since"
            case .ifNoneMatch:
                return "If-None-Match"
            case .ifRange:
                return "If-Range"
            case .ifUnmodifiedSince:
                return "If-Unmodified-Since"
            case .maxForwards:
                return "Max-Forwards"
            case .pragma:
                return "Pragma"
            case .proxyAuthorization:
                return "Proxy-Authorization"
            case .proxyConnection:
                return "Proxy-Connection"
            case .referer:
                return "Referer"
            case .userAgent:
                return "User-Agent"
            case .upgrade:
                return "Upgrade"
            case .via:
                return "Via"
            case .warning:
                return "Warning"
            case .xATTDeviceId:
                return "X-ATT-DeviceId"
            case .xCsrfToken:
                return "X-Csrf-Token"
            case .xForwardedHost:
                return "X-Forwarded-Host"
            case .xForwardedProto:
                return "X-Forwarded-Proto"
            case .xHttpMethodOverride:
                return "X-Http-Method-Override"
            case .xUIDH:
                return "X-UIDH"
            case .xWapProfile:
                return "X-Wap-Profile"
            case .custom(let value):
                return value
            }
        }
        
        public static func ==(lhs : HeaderField, rhs : HeaderField) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    }
}

