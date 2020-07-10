//
//  File.swift
//  
//
//  Created by Jann Schafranek on 10.07.20.
//

#if os(iOS)

import Foundation
import SwiftUI
import UIKit

private let boldIndicator: Character = "*"
private let italicIndicator: Character = "_"

public extension String {
    
    func markdowned(with style: UIFont.TextStyle = .body) -> NSAttributedString {
        let font = UIFont.preferredFont(forTextStyle: style)
        let bold = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits([.traitBold])!, size: font.pointSize)
        let italic = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits([.traitItalic])!, size: font.pointSize)
        let boldItalic = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic])!, size: font.pointSize)
        
        var isBold = false
        var isItalic = false
        
        let string = NSMutableAttributedString()
        var last: Character?
        for char in self {
            let lastWasSame = (char == last)
            last = char
            
            switch char {
            case boldIndicator, italicIndicator:
                if char == boldIndicator {
                    isBold.toggle()
                } else {
                    isItalic.toggle()
                }
                
                if !lastWasSame {
                    continue
                }
            default:
                break
            }
            
            let currentFont: UIFont
            switch (isBold, isItalic) {
            case (false, false):
                currentFont = font
            case (false, true):
                currentFont = italic
            case (true, false):
                currentFont = bold
            case (true, true):
                currentFont = boldItalic
            }
            
            string.append(NSAttributedString(string: String(char), attributes: [.font: currentFont]))
        }
        
        return string
    }
}

#endif
