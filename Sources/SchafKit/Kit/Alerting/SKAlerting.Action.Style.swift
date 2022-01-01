import Foundation

extension SKAlerting.Action {
    /// The style applied to a SKAlerting.Action.
    public enum Style {
        /// The default style.
        case `default`
        
        /// A style that indicates the action cancels the operation and leaves things unchanged.
        case cancel
        
        /// A style that indicates the action might change or delete data.
        case destructive
    }
}

