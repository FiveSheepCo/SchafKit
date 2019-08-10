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
    /// A class acting as a proxy to make network requests to a given endpoint.
    public class Endpoint {
        /// The base URL.
        public let baseURL : String
        /**
         The base options.
         
         - remark: Each option will be overwritten, **not** extended, if the options for a single request contains the same option with different parameters.
         */
        public let baseOptions : OKOptionSet<OKNetworking.Request.Options>
        
        /**
         Returns a new `OKNetworking.Endpoint`.
         
         - Note : When no protocol is defined in the baseURL explicitly, https will be used.
         */
        public init (url : String, baseOptions : OKOptionSet<OKNetworking.Request.Options> = []) {
            let preposition : String = url.contains("://") ? .empty : "https://"
            
            self.baseURL = preposition + url.removingOccurancesAtEnd(of: "/")
            self.baseOptions = baseOptions
        }
        
        /// Makes a network request with the given path appended to the responders base url and options and calls the completion handler when finished.
        public func request(path : String,
                             options : OKOptionSet<OKNetworking.Request.Options> = [],
                             completion: @escaping RequestCompletionBlock) {
            OKNetworking.request(url: baseURL + "/" + path.removingOccurancesAtStart(of: "/"),
                                 options: baseOptions + options, completion: completion)
        }
        
        /// Returns a `OKNetworking.Endpoint` by appending the given path component to the base url of the responder.
        public func endpointByAppending(pathComponent : String) -> Endpoint {
            return Endpoint(url: baseURL + "/" + pathComponent.removingOccurancesAtStart(of: "/"), baseOptions: baseOptions)
        }
    }
}
