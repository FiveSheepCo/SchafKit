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

#if canImport(AppKit)
import AppKit

class _MultiInputView : NSView {
    var textFields:[NSTextField] = []
    
    init?(configurations:[OKAlerting.TextFieldConfiguration]) {
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
            
            // TODO: 8 as constant in OpenKit
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
