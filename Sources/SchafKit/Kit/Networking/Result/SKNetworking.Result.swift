import Foundation

extension SKNetworking {
    /// A network request result.
    public struct RequestResult {
        /// The response.
        public let response : SKNetworking.Response
        /// The response.
        public let originalRequest : URLRequest
        /// The data.
        public let data : Data
        
        internal init?(data : Data?, originalRequest : URLRequest, response : URLResponse?) {
            guard let data = data, let response = response else {
                return nil
            }
            
            self.data = data
            self.originalRequest = originalRequest
            self.response = SKNetworking.Response(response: response)
        }
        
        /// The data as a `String`.
        public var stringValue : String? {
            return String(data: data, encoding: response.encoding)
        }
        
        /// The data as a `SKJsonRepresentable`.
        public var jsonValue : SKJsonRepresentable? {
            return SKJsonRepresentable(jsonRepresentation: data)
        }
    }
    
    /// A network download request result.
    public struct DownloadResult {
        /// The response.
        public let response : SKNetworking.Response
        /// The url.
        public let url : URL
        
        internal init?(url : URL?, response : URLResponse?) {
            guard let url = url, let response = response else {
                return nil
            }
            
            self.url = url
            self.response = SKNetworking.Response(response: response)
        }
    }
}

