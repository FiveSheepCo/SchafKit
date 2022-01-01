import Foundation
#if os(iOS)
import UIKit

public extension Hashable {
    
    /// Shares the responder using a `UIActivityViewController`.
    @available(iOSApplicationExtension, unavailable)
    func share(applicationActivities: [UIActivity]? = nil) {
        let controller : UIActivityViewController
        
        controller = UIActivityViewController(activityItems: [self], applicationActivities: applicationActivities)
        
        controller.show(type: .present)
    }
}
#endif
