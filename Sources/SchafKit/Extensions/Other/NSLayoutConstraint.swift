#if os(OSX)
    import AppKit
#elseif os(iOS)
    import UIKit
#endif

#if os(OSX) || os(iOS)
public extension NSLayoutConstraint {
    
    /// Activates the receiver.
    func activate(){
        self.isActive = true
    }
    
    /// Deactivates the receiver.
    func deactivate(){
        self.isActive = false
    }
}
#endif
