//
//  File.swift
//  
//
//  Created by Jann Schafranek on 13.08.20.
//

#if os(iOS)
import UIKit
import SwiftUI

public struct EmojiTextFieldView: UIViewRepresentable {
    
    @Binding var text: String
    
    public init(text: Binding<String>) {
        self._text = text
    }
    
    public func makeUIView(context: Context) -> EmojiTextField {
        return context.coordinator.textField
    }
    
    public func updateUIView(_ uiView: EmojiTextField, context: Context) {}
    
    // - MARK: Coordinator
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        let textField = EmojiTextField()
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
            
            super.init()
            
            self.textField.delegate = self
            self.textField.becomeFirstResponder()
        }
        
        public func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

public class EmojiTextField: UITextField {

    // required for iOS 13
    public override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard

    public override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}
#endif
