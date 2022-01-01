import Foundation
#if os(iOS) || os(tvOS)
import UIKit

public extension UIAlertController {
    
    // MARK: - Variables
    
    /**
     Returns the strings in all the `UITextFields` contained.
    
     - Note : The count of the array is always equal to the number of `UITextFields` contained by the `UIAlertController`.
    */
    var textFieldValues:[String]{
        return (textFields ?? []).map({ (field) -> String in
            return field.text ?? .empty
        })
    }
    
    // MARK: - Managing TextFields
    
    /// Adds a `UITextField` using the specified `SKAlerting.TextFieldConfiguration`.
    func addTextField(configuration : SKAlerting.TextFieldConfiguration){
        addTextField(configurationHandler: { (field) in
            field.text = configuration.text
            field.placeholder = configuration.placeholder
            field.isSecureTextEntry = configuration.isPassword
            
            field.textColor = .black
        })
    }
    
    // MARK: - Managing Actions
    
    /// Adds an action using the specified `SKAlerting.Action`.
    func addAction(action : SKAlerting.Action){
        let style : UIAlertAction.Style
        switch action.style {
        case .default:
            style = .default
        case .cancel:
            style = .cancel
        case .destructive:
            style = .destructive
        }
        
        let block : OKBlock?
        if let handler = action.handler {
            block = {
                handler(action, self.textFieldValues)
            }
        }else {
            block = nil
        }
        
        addAction(title: action.title, style: style, handler: block)
    }
    
    /**
     Adds an action using the specified parameters.
    
     - Parameters:
       - title : The title of the action.
       - style : The style of the action.
       - handler : The handler to execute when the action gets selected.
    */
    func addAction(title : String, style : UIAlertAction.Style = .default, handler : OKBlock? = nil){
        let block:((UIAlertAction) -> Void)?
        if let handler = handler {
            block = { (action : UIAlertAction) in
                handler()
            }
        }else {
            block = nil
        }
        addAction(UIAlertAction(title: title, style: style, handler: block))
    }
    
    /**
     Adds an action with the localized title 'OK'.
    
     - Parameters:
       - handler : The handler to execute when the action gets selected.
    */
    func addOKAction(handler: @escaping SKAlerting.Action.Block = { (action, arr) in}){ // TODO: Add `= nil` when bug is resolved by apple
        addAction(action : SKAlerting.Action.constructOKAction(handler: handler))
    }
    
    /**
     Adds an action with the localized title 'Cancel' and the style `.cancel`.
    
     - Parameters:
       - handler : The handler to execute when the action gets selected.
    */
    func addCancelAction(handler: @escaping SKAlerting.Action.Block = { (action, arr) in}){
        addAction(action : SKAlerting.Action.constructCancelAction(handler: handler))
    }
    
    // MARK: - Show Controller
    
    /// Shows the receiver after adding a localized 'OK' button to it.
    @available(iOSApplicationExtension, unavailable)
    func showWithOKButton(){
        addOKAction()
        show(type: .present)
    }
    
    /// Shows the receiver after adding a localized 'Cancel' button to it.
    @available(iOSApplicationExtension, unavailable)
    func showWithCancelButton(){
        addCancelAction()
        show(type: .present)
    }
}
#endif
