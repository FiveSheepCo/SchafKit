#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

public extension SKNetworking.Request {
    /// The body to use on a network request.
    ///
    /// - note: The type, if it is defined, is added to the network request, but can be overwritten manually.
    enum Body {
        /// Defines a form data body.
        case formData (value: [String : String])
        
        /// Defines a x-www-form-urlencoded body.
        case xWwwFormUrlencoded (value: [String : String])
        
        /// Defines a raw body.
        case raw (value : String, type : String)
        
        /// Defines a binary body.
        case binary (value : Data, type : String)
        
        /// The body data.
        public var body : Data? {
            switch self {
            case .formData(_):
                fatalError("not yet implemented") // TODO: Implement (see https://www.w3.org/TR/html401/interact/forms.html#h-17.13.4.2)
            case .xWwwFormUrlencoded(let value):
                return value.toQueryString().data(using: .utf8)
            case .raw(let value, _):
                return value.data(using: .utf8)
            case .binary(let value, _):
                return value
            }
        }
        
        /// The body type, if it's defined.
        public var type : String? {
            switch self {
            case .xWwwFormUrlencoded:
                return "application/x-www-form-urlencoded"
            case .formData:
                return "multipart/form-data"
            case .raw(_, let contentType), .binary(_, let contentType):
                return contentType
            }
        }
    }
}
#endif
