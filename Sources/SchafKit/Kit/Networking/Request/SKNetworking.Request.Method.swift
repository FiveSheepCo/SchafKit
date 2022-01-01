import Foundation

public extension SKNetworking.Request {
    /// A method to use on a network request.
    enum Method : String, CaseIterable {
        /// The `GET` method.
        case get = "GET"
        
        /// The `HEAD` method.
        case head = "HEAD"
        
        /// The `POST` method.
        case post = "POST"
        
        /// The `PUT` method.
        case put = "PUT"
        
        /// The `DELETE` method.
        case delete = "DELETE"
        
        /// The `TRACE` method.
        case trace = "TRACE"
        
        /// The `OPTIONS` method.
        case options = "OPTIONS"
        
        /// The `CONNECT` method.
        case connect = "CONNECT"
        
        /// The `PATCH` method.
        case patch = "PATCH"
        
        init? (rawValueIgnoringCase: String) {
            if let value = Method(rawValue: rawValueIgnoringCase.uppercased()) {
                self = value
            } else {
                return nil
            }
        }
    }
}

