#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

public class SKAlerting {
    
    /**
     Displays an alert.
    
     - Remark : This crashes on watchOS if given a non-empty `textFieldConfigurations`, since there are no text fields in watchOS. This is a deliberate design choice to unify functions of this framework between all platforms.
    */
    @available(iOSApplicationExtension, unavailable)
    public class func showAlert(title : String?,
                         message : String? = nil,
                         showOKAction : Bool = true,
                         showCancelAction : Bool = false,
                         SKBlock : SKAlerting.Action.Block? = nil,
                         cancelBlock : SKAlerting.Action.Block? = nil,
                         additionalActions:[SKAlerting.Action] = [],
                         textFieldConfigurations:[SKAlerting.TextFieldConfiguration] = [],
                         preferredStyle: SKAlerting.Style = .alert)
    {
        var actions:[SKAlerting.Action] = additionalActions
        
        if showOKAction {
            actions.insert(SKAlerting.Action.constructOKAction(handler: SKBlock), at: 0)
        }
        
        if showCancelAction {
            actions.append(SKAlerting.Action.constructCancelAction(handler: cancelBlock))
        }
        
        _showAlert(title: title,
                   message: message,
                   actions: actions,
                   textFieldConfigurations: textFieldConfigurations,
                   preferredStyle: preferredStyle)
    }
    
    /**
     Displays a prompt with a title, a message, text fields, an OK button and a Cancel button.
    
     - Parameters:
       - completion : The block to call after the user finishes input by tapping the OK button.
       - cancellation : The block to call after the user cancels input by tapping the Cancel button.
    
     - Remark : This crashes on watchOS, since there are no text fields in watchOS. This is a deliberate design choice to unify functions of this framework between all platforms.
    */
    @available(iOSApplicationExtension, unavailable)
    public class func showPrompt(title : String?,
                          message : String? = nil,
                          textFieldConfigurations:[SKAlerting.TextFieldConfiguration] = [],
                          completion : SKAlerting.Action.Block? = nil,
                          cancellation : SKBlock? = nil)
    {
        showAlert(title: title,
                  message: message,
                  showCancelAction: true,
                  SKBlock: completion,
                  cancelBlock: { (_, _) in cancellation?() },
                  textFieldConfigurations: textFieldConfigurations)
    }
    
    /**
     Displays a login prompt with a title, a message, a user text field, a password text field, an OK button and a Cancel button.
    
     - Parameters:
       - title : The title of the login prompt. The default value is an app-specific localization of 'Login'.
       - userPlaceholder : The placeholder of the user text field. The default value is an app-specific localization of 'Username'.
       - passwordPlaceholder : The placeholder of the password text field. The default value is an app-specific localization of 'Password'.
       - completion : The block to call after the user finishes input by tapping the OK button.
       - cancellation : The block to call after the user cancels input by tapping the Cancel button.
    
     - Remark : This crashes on watchOS, since there are no text fields in watchOS. This is a deliberate design choice to unify functions of this framework between all platforms.
    */
    @available(iOSApplicationExtension, unavailable)
    public class func showLoginPrompt(title : String = "Login".localized,
                               message : String? = nil,
                               userPlaceholder : String = "Username".localized,
                               passwordPlaceholder : String = "Password".localized,
                               completion:@escaping SKLoginReturnBlock,
                               cancellation : SKBlock? = nil)
    {
        showPrompt(title: title,
                   message: message,
                   textFieldConfigurations: [SKAlerting.TextFieldConfiguration(placeholder: userPlaceholder),
                                             SKAlerting.TextFieldConfiguration(placeholder: passwordPlaceholder, isPassword: true)],
                   completion: { (action, values) in completion(values[0], values[1]) },
                   cancellation: cancellation)
    }
}
#endif
