#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

/// A class helping to make web requests.
public class SKNetworking {
    
    /// Makes a network request with the given url and options and calls the completion handler when finished.
    public class func request(
        url : String,
        options : SKOptionSet<SKNetworking.Request.Options> = []
    ) async throws -> SKNetworking.RequestResult {
        try await withCheckedThrowingContinuation({ completion in
            _Helper.shared.request(url: url, options: options, completion: {
                completion.resume(with: $0)
            })
        })
    }
    
    /// Makes a network request with the given url and options and calls the completion handler when finished.
    public class func request(
        url : String,
        options : SKOptionSet<SKNetworking.Request.Options> = [],
        completion: @escaping RequestCompletionBlock
    ) {
        _Helper.shared.request(url: url, options: options, completion: completion)
    }
    
    /// Makes a network download request with the given url and options and calls the completion handler when finished.
    public class func requestDownload(
        url : String,
        options : SKOptionSet<SKNetworking.Request.Options> = [],
        update : @escaping DownloadRequestUpdateBlock = {_,_ in },
        completion: @escaping DownloadRequestCompletionBlock
    ) {
        _Helper.shared.requestDownload(url: url, options: options, update: update, completion: completion)
    }
}
#endif
