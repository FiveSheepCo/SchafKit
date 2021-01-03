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

extension OKAlerting {
    
    class func _showAlert(title : String?,
                          message : String?,
                          actions:[OKAlerting.Action] = [],
                          textFieldConfigurations:[OKAlerting.TextFieldConfiguration] = [],
                          preferredStyle: OKAlerting.Style = .alert)
    {
        let alert = NSAlert()
        
        alert.messageText = title ?? .empty
        alert.informativeText = message ?? .empty
        
        for action in actions {
            alert.addButton(withTitle: action.title)
        }
        
        alert.layout()
        
        // TODO: Make switching with tab possible
        //let inputView = _MultiInputView(configurations: textFieldConfigurations)
        //inputView?.frame.size.width = alert.window.frame.size.width - 123 // TODO: Make constant
        //alert.accessoryView = inputView
        
        // TODO: Decide : Should this actually be synchronous?
        let response = alert.runModal()
        
        let firstButtonRawValue = NSApplication.ModalResponse.alertFirstButtonReturn.rawValue
        
        let action = actions[response.rawValue - firstButtonRawValue]
        action.handler?(action, inputView?.values ?? [])
    }
}
#endif
