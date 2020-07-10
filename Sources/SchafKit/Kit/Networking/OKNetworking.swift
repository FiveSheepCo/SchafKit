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

/// A class helping to make web requests.
public class OKNetworking {
    
    /// Makes a network request with the given url and options and calls the completion handler when finished.
    public class func request(url : String,
                               options : OKOptionSet<OKNetworking.Request.Options> = [],
                               completion: @escaping RequestCompletionBlock) {
        _Helper.shared.request(url: url, options: options, completion: completion)
    }
    
    /// Makes a network download request with the given url and options and calls the completion handler when finished.
    public class func requestDownload(url : String,
                               options : OKOptionSet<OKNetworking.Request.Options> = [],
                               update : @escaping DownloadRequestUpdateBlock = {_,_ in },
                               completion: @escaping DownloadRequestCompletionBlock) {
        _Helper.shared.requestDownload(url: url, options: options, update: update, completion: completion)
    }
}
