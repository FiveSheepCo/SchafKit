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

public extension SKNetworking.Request {
    /// Options to use on a network request.
    enum Options : SKOptions {
        /// Defines the request method to use. The default value is `.get`.
        case requestMethod (value : SKNetworking.Request.Method)
        /// Defines the request body.
        case body (value : SKNetworking.Request.Body)
        /// Defines the header fields.
        case headerFields (value: [SKNetworking.Request.HeaderField : String])
        // TODO: `automaticallyBypassHTTPS`?
        /// Defines an auth challenge handler which handles authentication challenges when needed.
        case authChallengeHandler (value : SKNetworking.AuthChallengeBlock)
        /// Defines the cache policy. The default value is `.useProtocolCachePolicy`.
        case cachePolicy (value : URLRequest.CachePolicy)
        /// Defines the timeout interval. The default value is `60`.
        case timeoutInterval (value : TimeInterval)
    }
}

