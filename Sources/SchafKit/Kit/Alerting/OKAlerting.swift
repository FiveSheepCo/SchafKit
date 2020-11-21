//  Copyright (c) 2015 - 2019 Jann Schafranek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public class OKAlerting {
    
    /**
     Displays an alert.
    
     - Remark : This crashes on watchOS if given a non-empty `textFieldConfigurations`, since there are no text fields in watchOS. This is a deliberate design choice to unify functions of this framework between all platforms.
    */
    public class func showAlert(title : String?,
                         message : String? = nil,
                         showOKAction : Bool = true,
                         showCancelAction : Bool = false,
                         okBlock : OKAlerting.Action.Block? = nil,
                         cancelBlock : OKAlerting.Action.Block? = nil,
                         additionalActions:[OKAlerting.Action] = [],
                         textFieldConfigurations:[OKAlerting.TextFieldConfiguration] = [],
                         preferredStyle: OKAlerting.Style = .alert)
    {
        var actions:[OKAlerting.Action] = additionalActions
        
        if showOKAction {
            actions.insert(OKAlerting.Action.constructOKAction(handler: okBlock), at: 0)
        }
        
        if showCancelAction {
            actions.append(OKAlerting.Action.constructCancelAction(handler: cancelBlock))
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
    public class func showPrompt(title : String?,
                          message : String? = nil,
                          textFieldConfigurations:[OKAlerting.TextFieldConfiguration] = [],
                          completion : OKAlerting.Action.Block? = nil,
                          cancellation : OKBlock? = nil)
    {
        showAlert(title: title,
                  message: message,
                  showCancelAction: true,
                  okBlock: completion,
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
    public class func showLoginPrompt(title : String = "Login".localized,
                               message : String? = nil,
                               userPlaceholder : String = "Username".localized,
                               passwordPlaceholder : String = "Password".localized,
                               completion:@escaping OKLoginReturnBlock,
                               cancellation : OKBlock? = nil)
    {
        showPrompt(title: title,
                   message: message,
                   textFieldConfigurations: [OKAlerting.TextFieldConfiguration(placeholder: userPlaceholder),
                                             OKAlerting.TextFieldConfiguration(placeholder: passwordPlaceholder, isPassword: true)],
                   completion: { (action, values) in completion(values[0], values[1]) },
                   cancellation: cancellation)
    }
}
