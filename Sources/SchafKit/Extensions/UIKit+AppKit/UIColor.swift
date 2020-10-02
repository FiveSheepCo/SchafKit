//  Copyright (c) 2020 Quintschaf GbR
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

#if os(OSX)
    import AppKit
    
    public typealias UIColor = NSColor
#elseif os(watchOS)
    import WatchKit
#else
    import UIKit
#endif

public extension UIColor {
    
    private var selfAsSRGB: UIColor {
        #if os(iOS)
        return self
        #else
        if self.colorSpace == .sRGB {
            return self
        }
        return self.usingColorSpace(.sRGB)!
        #endif
    }
    
    /// Returns a `OKRGBARepresentation` representing the color.
    var rgbaRepresentation : OKRGBARepresentation {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        var alpha : CGFloat = 0
        
        #if os(OSX)
        selfAsSRGB.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #else
        if !selfAsSRGB.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            guard let components = self.cgColor.components, components.count >= 3 else {
                fatalError("rgbaRepresentation could not be evaluated properly.")
            }
            
            red = components[0]
            green = components[1]
            blue = components[2]
            alpha = components[ifExists: 3] ?? 1
        }
        #endif
        
        return OKRGBARepresentation(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// Returns a `OK8BitRGBARepresentation` representing the color.
    var bitRGBARepresentation : OK8BitRGBARepresentation {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        var alpha : CGFloat = 0
        
        #if os(OSX)
        selfAsSRGB.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #else
        if !selfAsSRGB.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            guard let components = self.cgColor.components, components.count >= 3 else {
                fatalError("rgbaRepresentation could not be evaluated properly.")
            }
            
            red = components[0]
            green = components[1]
            blue = components[2]
            alpha = components[ifExists: 3] ?? 1
        }
        #endif
        
        return OK8BitRGBARepresentation(red : UInt8(red * 255), green : UInt8(green * 255), blue : UInt8(blue * 255), alpha : UInt8(alpha * 255))
    }
    
    /// Returns a `OKHSLARepresentation` representing the color.
    var HSLARepresentation : OKHSLARepresentation {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        
        #if os(OSX)
        selfAsSRGB.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        #else
        if !selfAsSRGB.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            fatalError()
        }
        #endif
        
        return OKHSLARepresentation(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: alpha
        )
    }
    
    /// Initializes and returns a color object using the specified `OKRGBARepresentation`.
    convenience init(representation : OKRGBARepresentation) {
        self.init(intermediateDisplayP3Red: representation.red,
                  green: representation.green,
                  blue: representation.blue,
                  alpha: representation.alpha)
    }
    
    /// Initializes and returns a color object using the specified `OK8BitRGBARepresentation`.
    convenience init(representation : OK8BitRGBARepresentation) {
        self.init(intermediateDisplayP3Red : CGFloat(representation.red)/255,
                  green : CGFloat(representation.green)/255,
                  blue : CGFloat(representation.blue)/255,
                  alpha : CGFloat(representation.alpha)/255)
    }
    
    /// Initializes and returns a color object using the specified RGB component values.
    convenience init(red : CGFloat, green : CGFloat, blue : CGFloat) {
        self.init(intermediateDisplayP3Red: red,
                  green: green,
                  blue: blue,
                  alpha: 1)
    }
    
    /// Initializes and returns a color object using the specified RGB component values.
    convenience init(representation: OKHSLARepresentation) {
        self.init(
            hue: representation.hue,
            saturation: representation.saturation,
            brightness: representation.brightness,
            alpha: representation.alpha
        )
    }
    
    internal convenience init(intermediateDisplayP3Red red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat) {
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, *) {
            self.init(displayP3Red: red,
                      green: green,
                      blue: blue,
                      alpha: alpha)
        } else {
            self.init(red: red,
                      green: green,
                      blue: blue,
                      alpha: alpha)
        }
    }
    
    /// Initializes and returns a color object using the specified grayscale value.
    convenience init(white : CGFloat) {
        self.init(white: white, alpha: 1)
    }
}
