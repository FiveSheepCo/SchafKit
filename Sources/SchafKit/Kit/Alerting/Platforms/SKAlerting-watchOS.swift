#if canImport(WatchKit)
import WatchKit

extension SKAlerting {
    
    class func _showAlert(title : String?,
                         message : String?,
                         actions:[SKAlerting.Action] = [],
                         textFieldConfigurations:[SKAlerting.TextFieldConfiguration] = [],
                         preferredStyle: SKAlerting.Style = .alert)
    {
        guard textFieldConfigurations.isEmpty else {
            fatalError("TextFields are not supported in alerts on watchOS.")
        }
        
        // TODO: Look to make this compatible with watchOS 2
        // TODO: Do this via the rootInterfaceController?
        WKExtension.shared().visibleInterfaceController?
            .presentAlert(withTitle: title,
                          message: message,
                          preferredStyle: .alert,
                          actions: actions.map({ (action) -> WKAlertAction in
                            return WKAlertAction(action: action)
                          }))
    }
}

extension WKAlertAction {
    
    /// Initializes a new `WKAlertAction` with the given `JSAlertAction`.
    convenience init(action : SKAlerting.Action) {
        let style : WKAlertActionStyle
        switch action.style {
        case .default:
            style = .default
        case .cancel:
            style = .cancel
        case .destructive:
            style = .destructive
        }
        self.init(title: action.title, style: style) {
            action.handler?(action, [])
        }
    }
}

#endif
