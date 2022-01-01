#if os(iOS)
import UIKit

public extension UIDevice {
    
    @available(iOSApplicationExtension, unavailable)
    var hasNotch: Bool {
        return UIApplication.shared.windows.any { $0.safeAreaInsets.bottom > 0 }
    }
}

#endif
