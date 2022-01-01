#if os(iOS) || os(tvOS)
import UIKit
#endif

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
