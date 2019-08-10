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
    /// A method to use on a network request.
    enum Method : String, CaseIterable {
        /// The `GET` method.
        case get = "GET"
        
        /// The `HEAD` method.
        case head = "HEAD"
        
        /// The `POST` method.
        case post = "POST"
        
        /// The `PUT` method.
        case put = "PUT"
        
        /// The `DELETE` method.
        case delete = "DELETE"
        
        /// The `TRACE` method.
        case trace = "TRACE"
        
        /// The `OPTIONS` method.
        case options = "OPTIONS"
        
        /// The `CONNECT` method.
        case connect = "CONNECT"
        
        /// The `PATCH` method.
        case patch = "PATCH"
        
        init? (rawValueIgnoringCase: String) {
            if let value = Method(rawValue: rawValueIgnoringCase.uppercased()) {
                self = value
            } else {
                return nil
            }
        }
    }
}

