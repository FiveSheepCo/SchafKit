#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

extension SKNetworking {
    /// A class acting as a proxy to make network requests to a given endpoint.
    public class Endpoint {
        /// The base URL.
        public let baseURL : String
        /**
         The base options.
         
         - remark: Each option will be overwritten, **not** extended, if the options for a single request contains the same option with different parameters.
         */
        public let baseOptions : SKOptionSet<SKNetworking.Request.Options>
        
        /**
         Returns a new `SKNetworking.Endpoint`.
         
         - Note : When no protocol is defined in the baseURL explicitly, https will be used.
         */
        public init (url : String, baseOptions : SKOptionSet<SKNetworking.Request.Options> = []) {
            let preposition : String = url.contains("://") ? .empty : "https://"
            
            self.baseURL = preposition + url.removingOccurancesAtEnd(of: "/")
            self.baseOptions = baseOptions
        }
        
        /// Makes a network request with the given path appended to the responders base url and options and calls the completion handler when finished.
        public func request(path : String,
                             options : SKOptionSet<SKNetworking.Request.Options> = [],
                             completion: @escaping RequestCompletionBlock) {
            SKNetworking.request(url: baseURL + "/" + path.removingOccurancesAtStart(of: "/"),
                                 options: baseOptions + options, completion: completion)
        }
        
        /// Makes a network request with the given url and options and calls the completion handler when finished.
        public func request(
            path : String,
            options : SKOptionSet<SKNetworking.Request.Options> = []
        ) async throws -> SKNetworking.RequestResult {
            try await withCheckedThrowingContinuation({ completion in
                self.request(path: path, options: options, completion: {
                    completion.resume(with: $0)
                })
            })
        }
        
        /// Returns a `SKNetworking.Endpoint` by appending the given path component to the base url of the responder.
        public func endpointByAppending(pathComponent : String) -> Endpoint {
            return Endpoint(url: baseURL + "/" + pathComponent.removingOccurancesAtStart(of: "/"), baseOptions: baseOptions)
        }
    }
}
#endif
