#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

extension SKAlerting {
    /// An action to be used on alert prompts across iOS, tvOS, watchOS and macOS.
    public struct Action {
        let title : String
        let style : Style
        let handler : Block?
        
        /// Initializes a new action.
        public init(title : String,
                    style : Style = .default,
                    handler : Block? = nil) {
            self.title = title
            self.style = style
            self.handler = handler
        }
        
        internal static func constructOKAction(handler : Block?) -> Action {
            return Action(title: "OK".localized, handler: handler)
        }
        
        internal static func constructCancelAction(handler : Block?) -> Action {
            return Action(title: "Cancel".localized, style: .cancel, handler: handler)
        }
    }
}
#endif
