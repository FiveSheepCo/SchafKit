#if os(iOS) || os(tvOS)
import UIKit

extension SKAlerting {
    
    @available(iOSApplicationExtension, unavailable)
    class func _showAlert(title : String?,
                          message : String?,
                          actions:[SKAlerting.Action] = [],
                          textFieldConfigurations:[SKAlerting.TextFieldConfiguration] = [],
                          preferredStyle: SKAlerting.Style = .alert)
    {
        let controller = UIAlertController(title: title, message: message, preferredStyle: preferredStyle.value)
        
        for action in actions {
            controller.addAction(action: action)
        }
        
        for textFieldConfiguration in textFieldConfigurations {
            controller.addTextField(configuration: textFieldConfiguration)
        }
        
        controller.show(type: .present)
    }
}
#endif
