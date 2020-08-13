//
//  File.swift
//  
//
//  Created by Jann Schafranek on 13.08.20.
//

#if os(iOS)
import UIKit
import SwiftUI

struct EmojiTextFieldView: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> EmojiTextField {
        return context.coordinator.textField
    }
    
    func updateUIView(_ uiView: EmojiTextField, context: Context) {}
    
    // - MARK: Coordinator
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        let textField = EmojiTextField()
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
            
            super.init()
            
            self.textField.delegate = self
            self.textField.becomeFirstResponder()
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

class EmojiTextField: UITextField {

   // required for iOS 13
   override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}
#endif
