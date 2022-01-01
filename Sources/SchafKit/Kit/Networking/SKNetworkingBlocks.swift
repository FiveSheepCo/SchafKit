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
