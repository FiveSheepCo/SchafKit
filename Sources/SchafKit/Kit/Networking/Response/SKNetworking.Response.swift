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

extension SKNetworking {
    /// A network response.
    public struct Response {
        private struct Constants {
            static let standardTextEncoding = "utf-8"
        }
        
        /// The original system response.
        public let response : URLResponse
        
        /// The status code.
        public var statusCode : Int?{
            return (response as? HTTPURLResponse)?.statusCode
        }
        
        public var encoding : String.Encoding {
            let encodingName = response.textEncodingName ?? Constants.standardTextEncoding
            let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding(encodingName as CFString))
            return String.Encoding(rawValue: encoding)
        }
        
        /// The status.
        public var status : Status?{
            guard let statusCode = statusCode else {
                return nil
            }
            return Status(rawValue: statusCode)
        }
    }
}
