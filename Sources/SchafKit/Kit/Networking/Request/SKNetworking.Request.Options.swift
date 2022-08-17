#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

public extension SKNetworking.Request {
    /// Options to use on a network request.
    enum Options : SKOptions {
        /// Defines the request method to use. The default value is `.get`.
        case requestMethod (value : SKNetworking.Request.Method)
        /// Defines the request body.
        case body (value : SKNetworking.Request.Body)
        /// Defines the header fields.
        case headerFields (value: [SKNetworking.Request.HeaderField : String])
        // TODO: `automaticallyBypassHTTPS`?
        /// Defines an auth challenge handler which handles authentication challenges when needed.
        case authChallengeHandler (value : SKNetworking.AuthChallengeBlock)
        /// Defines the cache policy. The default value is `.useProtocolCachePolicy`.
        case cachePolicy (value : URLRequest.CachePolicy)
        /// Defines the timeout interval. The default value is `60`.
        case timeoutInterval (value : TimeInterval)
    }
}
#endif
