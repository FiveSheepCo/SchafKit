#if os(macOS)
import AppKit

extension SKAlerting {
    
    class func _showAlert(title : String?,
                          message : String?,
                          actions:[SKAlerting.Action] = [],
                          textFieldConfigurations:[SKAlerting.TextFieldConfiguration] = [],
                          preferredStyle: SKAlerting.Style = .alert)
    {
        let alert = NSAlert()
        
        alert.messageText = title ?? .empty
        alert.informativeText = message ?? .empty
        
        for action in actions {
            alert.addButton(withTitle: action.title)
        }
        
        alert.layout()
        
        // TODO: Make switching with tab possible
        let inputView = _MultiInputView(configurations: textFieldConfigurations)
        inputView?.frame.size.width = alert.window.frame.size.width - 123 // TODO: Make constant
        alert.accessoryView = inputView
        
        // TODO: Decide : Should this actually be synchronous?
        let response = alert.runModal()
        
        let firstButtonRawValue = NSApplication.ModalResponse.alertFirstButtonReturn.rawValue
        
        let action = actions[response.rawValue - firstButtonRawValue]
        action.handler?(action, inputView?.values ?? [])
    }
}
#endif
