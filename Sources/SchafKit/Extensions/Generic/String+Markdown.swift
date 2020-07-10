//
//  File.swift
//  
//
//  Created by Jann Schafranek on 10.07.20.
//

import Foundation
import SwiftUI

#if os(iOS)
import UIKit

extension UIFont {
    func withTraits(_ symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        return UIFont(
            descriptor: fontDescriptor.withSymbolicTraits(symbolicTraits)!,
            size: pointSize
        )
    }
}

extension UIFontDescriptor.SymbolicTraits {
    static var bold: UIFontDescriptor.SymbolicTraits {
        return .traitBold
    }
    
    static var italic: UIFontDescriptor.SymbolicTraits {
        return .traitItalic
    }
}
#elseif os(macOS)
public typealias UIFont = NSFont

extension NSFont {
    func withTraits(_ symbolicTraits: NSFontDescriptor.SymbolicTraits) -> NSFont {
        return NSFont(
            descriptor: fontDescriptor.withSymbolicTraits(symbolicTraits),
            size: pointSize
        )!
    }
}
#endif

private let boldIndicator: Character = "*"
private let italicIndicator: Character = "_"

public extension String {
    
    @available(macOS 10.16, *)
    func markdowned(with style: UIFont.TextStyle = .body) -> NSAttributedString {
        let font = UIFont.preferredFont(forTextStyle: style)
        let bold = font.withTraits([.bold])
        let italic = font.withTraits([.italic])
        let boldItalic = font.withTraits([.bold, .italic])
        
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
