#if os(macOS)
import AppKit

class _MultiInputView : NSView {
    var textFields:[NSTextField] = []
    
    init?(configurations:[SKAlerting.TextFieldConfiguration]) {
        guard configurations.count > 0 else {
            return nil
        }
        
        let textViewHeight : CGFloat = 21 // TODO: make constant or gather from somewhere
        let spaceHeight : CGFloat = 8 // TODO: make constant
        
        super.init(frame : NSRect(x: 0, y: 0, width: 0, height : CGFloat(configurations.count) * (textViewHeight + spaceHeight) - spaceHeight))
        
        var lastTextField : NSTextField?
        
        for configuration in configurations {
            let textField = configuration.isPassword ? NSSecureTextField() : NSTextField()
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            textField.placeholderString = configuration.placeholder
            
            textFields.append(textField)
            
            addSubview(textField)
            
            textField.leftAnchor.constraint(equalTo: self.leftAnchor).activate()
            textField.rightAnchor.constraint(equalTo: self.rightAnchor).activate()
            
            // TODO: 8 as constant in JSKit
            // TODO: a function constraining a view under another view with left and right insets
            
            if lastTextField == nil {
                textField.becomeFirstResponder()
            }
            
            (lastTextField?.bottomAnchor ?? self.topAnchor).constraint(equalTo: textField.topAnchor, constant: (lastTextField == nil) ? 0 : -8).activate()
            
            lastTextField?.nextKeyView = textField
            
            lastTextField = textField
        }
        
        self.bottomAnchor.constraint(equalTo: lastTextField!.bottomAnchor).activate()
    }
    
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        
        superview?.rightAnchor.constraint(equalTo: self.rightAnchor).activate()
        superview?.leftAnchor.constraint(equalTo: self.leftAnchor).activate()
    }
    
    required init?(coder decoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var values:[String]{
        return textFields.map({ (textField) -> String in
            textField.stringValue
        })
    }
}
#endif
