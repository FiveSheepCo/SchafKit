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

extension OKNetworking {
    /// A network request result.
    public struct RequestResult {
        /// The response.
        public let response : OKNetworking.Response
        /// The data.
        public let data : Data
        
        internal init?(data : Data?, response : URLResponse?) {
            guard let data = data, let response = response else {
                return nil
            }
            
            self.data = data
            self.response = OKNetworking.Response(response: response)
        }
        
        /// The data as a `String`.
        public var stringValue : String? {
            return String(data: data, encoding: response.encoding)
        }
        
        /// The data as a `OKJsonRepresentable`.
        public var jsonValue : OKJsonRepresentable? {
            return OKJsonRepresentable(jsonRepresentation: data)
        }
    }
    
    /// A network download request result.
    public struct DownloadResult {
        /// The response.
        public let response : OKNetworking.Response
        /// The url.
        public let url : URL
        
        internal init?(url : URL?, response : URLResponse?) {
            guard let url = url, let response = response else {
                return nil
            }
            
            self.url = url
            self.response = OKNetworking.Response(response: response)
        }
    }
}

