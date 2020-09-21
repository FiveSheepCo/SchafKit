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

public extension UIFont {
    func withTraits(_ symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        return UIFont(
            descriptor: fontDescriptor.withSymbolicTraits(symbolicTraits)!,
            size: pointSize
        )
    }
}

public extension UIFontDescriptor.SymbolicTraits {
    static var bold: UIFontDescriptor.SymbolicTraits {
        return .traitBold
    }
    
    static var italic: UIFontDescriptor.SymbolicTraits {
        return .traitItalic
    }
}
#elseif os(macOS)
public typealias UIFont = NSFont

public extension NSFont {
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

private let argumentIndicator: Character = "$"
private let argumentPluralizationStartIndicator: Character = "("
private let argumentPluralizationEndIndicator: Character = ")"
private let argumentPluralizationSeparationIndicator = "|"

public extension String {
    
    /**
     *   Marks down a string
     *
     *   Supports:
     *      - \* as indicator for beginning and end of bold
     *      - _ as indicator for beginning and end of italic
     *      - $n as a specifier for inserting the argument n
     *      - $n(a|b) as indicator that:
     *           - String a should be inserted when argument n is a number and equals 1
     *           - String b should be inserted else
     */
    @available(macOS 10.16, *)
    func markdowned(as style: UIFont.TextStyle = .body, with arguments: [String] = []) -> NSAttributedString {
        let font = UIFont.preferredFont(forTextStyle: style)
        let bold = font.withTraits([.bold])
        let italic = font.withTraits([.italic])
        let boldItalic = font.withTraits([.bold, .italic])
        
        var isBold = false
        var isItalic = false
        
        let string = NSMutableAttributedString()
        var toAppend: String = ""
        var last: Character?
        
        var argumentNumber: Int?
        var pluralizationContent: String?
        for (index, char) in (self + " ").enumerated() {
            let lastWasSame = (char == last)
            last = char
            
            // argumentNumber being set indicates there was an argument indicator
            if let curArgumentNumber = argumentNumber {
                // pluralizationContent being set indicates we are collecting pluralization content
                if let curPluralizationContent = pluralizationContent {
                    if char == argumentPluralizationEndIndicator {
                        let argument = arguments[/*ifExists:*/ curArgumentNumber]
                        
                        let pluralizationToUse = (abs(Double(argument) ?? 0) == 1) ? 0 : 1
                        toAppend = curPluralizationContent.components(separatedBy: argumentPluralizationSeparationIndicator)[/*ifExists:*/pluralizationToUse]
                        
                        argumentNumber = nil
                        pluralizationContent = nil
                    } else {
                        pluralizationContent = curPluralizationContent + String(char)
                    }
                    continue
                }
                
                if char.isNumber {
                    argumentNumber = curArgumentNumber * 10 + Int(String(char))!
                    continue
                } else if char == argumentPluralizationStartIndicator {
                    pluralizationContent = ""
                    continue
                } else {
                    toAppend = arguments[/*ifExists:*/ curArgumentNumber]
                    argumentNumber = nil
                }
            }
            
            switch char {
            case boldIndicator, italicIndicator, argumentIndicator:
                switch char {
                case boldIndicator:
                    isBold.toggle()
                case italicIndicator:
                    isItalic.toggle()
                default: // argumentIndicator
                    if argumentNumber == nil {
                        argumentNumber = 0
                    } else {
                        argumentNumber = nil
                    }
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
            
            string.append(NSAttributedString(string: toAppend + ((self.count == index) ? "" : String(char)), attributes: [.font: currentFont]))
            toAppend = ""
        }
        
        return string
    }
    
    /**
     *   Marks down a string
     *
     *   Supports:
     *      - \* as indicator for beginning and end of bold
     *      - _ as indicator for beginning and end of italic
     *      - $n as a specifier for inserting the argument n
     *      - $n(a|b) as indicator that:
     *           - String a should be inserted when argument n is a number and equals 1
     *           - String b should be inserted else
     */
    @available(macOS 10.16, *)
    func markdownedText(with font: Font = .body, with arguments: [String] = []) -> Text {
        
        var isBold = false
        var isItalic = false
        
        var text = Text("")
        var toAppend: String = ""
        var last: Character?
        
        var argumentNumber: Int?
        var pluralizationContent: String?
        for (index, char) in (self + " ").enumerated() {
            let lastWasSame = (char == last)
            last = char
            
            // argumentNumber being set indicates there was an argument indicator
            if let curArgumentNumber = argumentNumber {
                // pluralizationContent being set indicates we are collecting pluralization content
                if let curPluralizationContent = pluralizationContent {
                    if char == argumentPluralizationEndIndicator {
                        let argument = arguments[/*ifExists:*/ curArgumentNumber]
                        
                        let pluralizationToUse = (abs(Double(argument) ?? 0) == 1) ? 0 : 1
                        toAppend = curPluralizationContent.components(separatedBy: argumentPluralizationSeparationIndicator)[/*ifExists:*/pluralizationToUse]
                        
                        argumentNumber = nil
                        pluralizationContent = nil
                    } else {
                        pluralizationContent = curPluralizationContent + String(char)
                    }
                    continue
                }
                
                if char.isNumber {
                    argumentNumber = curArgumentNumber * 10 + Int(String(char))!
                    continue
                } else if char == argumentPluralizationStartIndicator {
                    pluralizationContent = ""
                    continue
                } else {
                    toAppend = arguments[/*ifExists:*/ curArgumentNumber]
                    argumentNumber = nil
                }
            }
            
            switch char {
            case boldIndicator, italicIndicator, argumentIndicator:
                switch char {
                case boldIndicator:
                    isBold.toggle()
                case italicIndicator:
                    isItalic.toggle()
                default: // argumentIndicator
                    if argumentNumber == nil {
                        argumentNumber = 0
                    } else {
                        argumentNumber = nil
                    }
                }
                
                if !lastWasSame {
                    continue
                }
            default:
                break
            }
            
            var textToAppend = Text(toAppend + ((self.count == index) ? "" : String(char))).font(font)
            
            if isBold {
                textToAppend = textToAppend.bold()
            }
            if isItalic {
                textToAppend = textToAppend.italic()
            }
            
            text = text + textToAppend
            toAppend = ""
        }
        
        return text
    }
}
