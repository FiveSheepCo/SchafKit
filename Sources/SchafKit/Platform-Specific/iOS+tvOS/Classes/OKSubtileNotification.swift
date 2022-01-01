#if os(iOS)
import UIKit

private let height : CGFloat = 20
private let actualHeight : CGFloat = 30

private let animationDuration : TimeInterval = 0.5
private let animationDamping : CGFloat = 0.5
private let animationVelocity : CGFloat = 0.5

private let showDuration : TimeInterval = 1

// TODO: Support phones with notches.

/// An object representing a subtile notification covering the status bar for a fixed duration.
///
/// - note: This does not support devices with a notch (such as the iPhone X) yet.
public class OKSubtileNotification {
    var title : String
    var duration : TimeInterval
    
    /**
     Returns a new `OKSubtileNotification`.
    
     - parameter title : The title to show on the notification.
     - parameter duration : The duration the notification should last before disappearing. The default value is 1.
    */
    public convenience init(title : String) {
        self.init(title: title, duration: showDuration)
    }
    
    /**
     Returns a new `OKSubtileNotification`.
    
     - parameter title : The title to show on the notification.
     - parameter duration : The duration the notification should last before disappearing. The default value is 1.
    */
    public init(title : String, duration : TimeInterval) {
        self.title = title
        self.duration = duration
    }
    
    /// Shows the notification.
    public func show() {
        OKSubtileNotification.show(with: title, duration: duration)
    }
    
    /**
     Shows a notification.
    
     - parameter title : The title to show on the notification.
     - parameter duration : The duration the notification should last before disappearing. The default value is 1.
    */
    public static func show(with title : String) {
        show(with: title, duration: showDuration)
    }
    
    /**
     Shows a notification.
    
     - parameter title : The title to show on the notification.
     - parameter duration : The duration the notification should last before disappearing. The default value is 1.
    */
    public static func show(with title : String, duration : TimeInterval) {
        let frame = CGRect(x: 0, y: -actualHeight, width : UIScreen.main.bounds.width, height: actualHeight)
        let notification = UIWindow(frame: frame)
        notification.windowLevel = UIWindow.Level.alert
        notification.backgroundColor = notification.tintColor
        notification.isHidden = false
        
        let label = UILabel(frame : CGRect(x: 0, y: actualHeight - height, width: frame.width, height: height))
        label.text = title
        label.font = UIFont.systemFont(ofSize: height / 1.5)
        label.textColor = UIColor.label
        label.textAlignment = .center
        notification.addSubview(label)
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: animationDamping, initialSpringVelocity: animationVelocity, options: [], animations: {
            notification.frame.origin.y += height
        }, completion: { (done) in
            UIView.animate(withDuration: animationDuration, delay: duration, usingSpringWithDamping: animationDamping, initialSpringVelocity: animationVelocity, options: [], animations: {
                notification.frame = frame
            }, completion: { (done) in
                notification.isHidden = true
            })
        })
    }
}
#endif
