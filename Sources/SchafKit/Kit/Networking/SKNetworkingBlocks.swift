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
    /// A network authentication challenge block.
    ///
    /// - Note : Resembles the standard authentication challenge block used by Apple in the URLSessionDelegate.
    public typealias AuthChallengeBlock = (_ challenge : URLAuthenticationChallenge, _ completionHandler:@escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) -> Void
    
    /// A network request completion block.
    public typealias RequestCompletionBlock = (_ result : Result<SKNetworking.RequestResult, Error>) -> Void
    /// A network download request update block.
    public typealias DownloadRequestUpdateBlock = (_ bytesWritten : Int64, _ bytesExpectedToWrite : Int64) -> Void
    /// A network download request completion block.
    public typealias DownloadRequestCompletionBlock = (_ result : Result<SKNetworking.DownloadResult, Error>) -> Void
}
