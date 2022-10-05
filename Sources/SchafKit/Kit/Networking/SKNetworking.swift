#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

/// A class helping to make web requests.
public class SKNetworking {
    public static let shared = SKNetworking()
    
    private let helper: _Helper
    
    private init() {
        self.helper = .shared
    }
    
    #if os(macOS)
    public init(httpsProxy: String, httpsProxyPort: Int) {
        self.helper = _Helper(httpsProxy: httpsProxy, httpsProxyPort: httpsProxyPort)
    }
    #endif
    
    /// Makes a network request with the given url and options and calls the completion handler when finished.
    public func request(
        url : String,
        options : SKOptionSet<SKNetworking.Request.Options> = []
    ) async throws -> SKNetworking.RequestResult {
        try await withCheckedThrowingContinuation({ completion in
            helper.request(url: url, options: options, completion: {
                completion.resume(with: $0)
            })
        })
    }
    
    /// Makes a network request with the given url and options and calls the completion handler when finished.
    public func request(
        url : String,
        options : SKOptionSet<SKNetworking.Request.Options> = [],
        completion: @escaping RequestCompletionBlock
    ) {
        helper.request(url: url, options: options, completion: completion)
    }
    
    /// Makes a network download request with the given url and options and calls the completion handler when finished.
    public func requestDownload(
        url : String,
        options : SKOptionSet<SKNetworking.Request.Options> = [],
        update : @escaping DownloadRequestUpdateBlock = {_,_ in },
        completion: @escaping DownloadRequestCompletionBlock
    ) {
        helper.requestDownload(url: url, options: options, update: update, completion: completion)
    }
}

extension SKNetworking {
    
    /// Makes a network request with the given url and options and calls the completion handler when finished.
    public class func request(
        url : String,
        options : SKOptionSet<SKNetworking.Request.Options> = []
    ) async throws -> SKNetworking.RequestResult {
        try await shared.request(url: url, options: options)
    }
    
    /// Makes a network request with the given url and options and calls the completion handler when finished.
    public class func request(
        url : String,
        options : SKOptionSet<SKNetworking.Request.Options> = [],
        completion: @escaping RequestCompletionBlock
    ) {
        shared.request(url: url, options: options, completion: completion)
    }
    
    /// Makes a network download request with the given url and options and calls the completion handler when finished.
    public class func requestDownload(
        url : String,
        options : SKOptionSet<SKNetworking.Request.Options> = [],
        update : @escaping DownloadRequestUpdateBlock = {_,_ in },
        completion: @escaping DownloadRequestCompletionBlock
    ) {
        shared.requestDownload(url: url, options: options, update: update, completion: completion)
    }
}
#endif
