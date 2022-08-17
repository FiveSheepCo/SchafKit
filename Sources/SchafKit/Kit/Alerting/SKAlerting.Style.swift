#if os(iOS) || os(tvOS)
import UIKit
#endif

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
extension SKAlerting {
    public enum Style {
        case alert, actionSheet
        
        #if os(iOS) || os(tvOS)
        var value : UIAlertController.Style {
            switch self {
            case .alert:
                return .alert
            case .actionSheet:
                return .actionSheet
            }
        }
        #endif
    }
}
#endif
