#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

extension SKNetworking.Response {
    /// Defines common response statuses.
    public enum Status : Int {
        case `continue` = 100, switchingProtocols = 101, processing = 102, earlyHints = 103
        case ok = 200, created = 201, accepted = 202, nonAuthoritativeInformation = 203, noContent = 204, resetContent = 205, partialContent = 206, multiStatus = 207, alreadyReported = 208, imUsed = 226
        case multipleChoices = 300, movedPermanently = 301, found = 302, seeOther = 303, notModified = 304, useProxy = 305, switchProxy = 306, temporaryRedirect = 307, permanentRedirect = 308
        case badRequest = 400, unauthorized = 401, paymentRequired = 402, forbidden = 403, notFound = 404, methodNotAllowed = 405, notAcceptable = 406, proxyAuthenticationRequired = 407, requestTimeout = 408, conflict = 409, gone = 410, lengthRequired = 411, preconditionFailed = 412, payloadTooLarge = 413, uriTooLong = 414, unsupportedMediaType = 415, rangeNotSatisfiable = 416, expectationFailed = 417, iMATeapot = 418, misdirectedRequest = 421, unprocessableEntity = 422, locked = 423, failedDependency = 424, upgradeRequired = 426, preconditionRequired = 428, tooManyRequests = 429, requestheaderFieldsTooLarge = 431, unavailableForLegalReasons = 451
        case internalServerError = 500, notImplemented = 501, badGateway = 502, serviceUnavailable = 503, gatewayTimeout = 504, httpVersionNotSupported = 505, variantAlsoNegotiates = 506, insufficientStorage = 507, loopDetected = 508, notExtended = 510, networkAuthenticationRequired = 511
        
        
        public var name : String {
            switch self {
            case .continue:
                return "Continue"
            case .switchingProtocols:
                return "Switching Protocols"
            case .processing:
                return "Processing"
            case .earlyHints:
                return "Early Hints"
            case .ok:
                return "OK"
            case .created:
                return "Created"
            case .accepted:
                return "Accepted"
            case .nonAuthoritativeInformation:
                return "Non-Authoritative Information"
            case .noContent:
                return "No Content"
            case .resetContent:
                return "Reset Content"
            case .partialContent:
                return "Partial Content"
            case .multiStatus:
                return "Multi-Status"
            case .alreadyReported:
                return "Already Reported"
            case .imUsed:
                return "IM Used"
            case .multipleChoices:
                return "Multiple Choices"
            case .movedPermanently:
                return "Moved Permanently"
            case .found:
                return "Found"
            case .seeOther:
                return "See Other"
            case .notModified:
                return "Not Modified"
            case .useProxy:
                return "Use Proxy"
            case .switchProxy:
                return "Switch Proxy"
            case .temporaryRedirect:
                return "Temporary Redirect"
            case .permanentRedirect:
                return "Permanent Redirect"
            case .badRequest:
                return "Bad Request"
            case .unauthorized:
                return "Unauthorized"
            case .paymentRequired:
                return "Payment Required"
            case .forbidden:
                return "Forbidden"
            case .notFound:
                return "Not Found"
            case .methodNotAllowed:
                return "Method Not Allowed"
            case .notAcceptable:
                return "Not Acceptable"
            case .proxyAuthenticationRequired:
                return "Proxy Authentication Required"
            case .requestTimeout:
                return "Request Timeout"
            case .conflict:
                return "Conflict"
            case .gone:
                return "Gone"
            case .lengthRequired:
                return "Length Required"
            case .preconditionFailed:
                return "Precondition Failed"
            case .payloadTooLarge:
                return "Payload Too Large"
            case .uriTooLong:
                return "URI Too Long"
            case .unsupportedMediaType:
                return "Unsupported Media Type"
            case .rangeNotSatisfiable:
                return "Range Not Satisfiable"
            case .expectationFailed:
                return "Expectation Failed"
            case .iMATeapot:
                return "I'm a teapot"
            case .misdirectedRequest:
                return "Misdirected Request"
            case .unprocessableEntity:
                return "Unprocessable Entity"
            case .locked:
                return "Locked"
            case .failedDependency:
                return "Failed Dependency"
            case .upgradeRequired:
                return "Upgrade Required"
            case .preconditionRequired:
                return "Precondition Required"
            case .tooManyRequests:
                return "Too Many Requests"
            case .requestheaderFieldsTooLarge:
                return "Request Header Fields Too Large"
            case .unavailableForLegalReasons:
                return "Unavailable For Legal Reasons"
            case .internalServerError:
                return "Internal Server Error"
            case .notImplemented:
                return "Not Implemented"
            case .badGateway:
                return "Bad Gateway"
            case .serviceUnavailable:
                return "Service Unavailable"
            case .gatewayTimeout:
                return "Gateway Timeout"
            case .httpVersionNotSupported:
                return "HTTP Version Not Supported"
            case .variantAlsoNegotiates:
                return "Variant Also Negotiates"
            case .insufficientStorage:
                return "Insufficient Storage"
            case .loopDetected:
                return "Loop Detected"
            case .notExtended:
                return "Not Extended"
            case .networkAuthenticationRequired:
                return "Network Authentication Required"
            }
        }
    }
}
#endif
