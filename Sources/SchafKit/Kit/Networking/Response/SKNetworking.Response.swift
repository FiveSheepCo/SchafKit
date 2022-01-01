import Foundation

extension SKNetworking {
    /// A network response.
    public struct Response {
        private struct Constants {
            static let standardTextEncoding = "utf-8"
        }
        
        /// The original system response.
        public let response : URLResponse
        
        /// The status code.
        public var statusCode : Int?{
            return (response as? HTTPURLResponse)?.statusCode
        }
        
        public var encoding : String.Encoding {
            let encodingName = response.textEncodingName ?? Constants.standardTextEncoding
            let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding(encodingName as CFString))
            return String.Encoding(rawValue: encoding)
        }
        
        /// The status.
        public var status : Status?{
            guard let statusCode = statusCode else {
                return nil
            }
            return Status(rawValue: statusCode)
        }
    }
}
