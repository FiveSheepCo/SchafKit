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

public extension OKNetworking.Request {
    /// The body to use on a network request.
    ///
    /// - note: The type, if it is defined, is added to the network request, but can be overwritten manually.
    enum Body {
        /// Defines a form data body.
        case formData (value: [String : String])
        
        /// Defines a x-www-form-urlencoded body.
        case xWwwFormUrlencoded (value: [String : String])
        
        /// Defines a raw body.
        case raw (value : String, type : String)
        
        /// Defines a binary body.
        case binary (value : Data, type : String)
        
        /// The body data.
        public var body : Data? {
            switch self {
            case .formData(_):
                fatalError("not yet implemented") // TODO: Implement (see https://www.w3.org/TR/html401/interact/forms.html#h-17.13.4.2)
            case .xWwwFormUrlencoded(let value):
                return value.toQueryString().data(using: .utf8)
            case .raw(let value, _):
                return value.data(using: .utf8)
            case .binary(let value, _):
                return value
            }
        }
        
        /// The body type, if it's defined.
        public var type : String? {
            switch self {
            case .xWwwFormUrlencoded:
                return "application/x-www-form-urlencoded"
            case .formData:
                return "multipart/form-data"
            case .raw(_, _), .binary(_, _):
                return nil
            }
        }
    }
}

