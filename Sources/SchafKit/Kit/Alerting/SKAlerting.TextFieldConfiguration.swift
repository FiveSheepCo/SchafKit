#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

extension SKAlerting {
    /// A text field configuration to be used on alert prompts across iOS, tvOS, watchOS and macOS.
    public struct TextFieldConfiguration {
        internal let placeholder : String
        internal let text : String?
        internal let isPassword : Bool
        
        /**
         Initializes a new `SKAlerting.TextFieldConfiguration`.
         
         - Parameters:
         - placeholder : The placeholder.
         - text : The text. Default is `nil`.
         - isPassword : Whether the configuration is for a text field in which a password will be entered.
         */
        public init(placeholder : String,
                    text : String? = nil,
                    isPassword : Bool = false) {
            self.placeholder = placeholder
            self.isPassword = isPassword
            self.text = text
        }
    }
}
#endif
