#if os(OSX) || os(iOS) || os(tvOS) || os(watchOS)
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
        #if os(macOS)
        return self.usingColorSpace(.sRGB)!
        #else
        return self
        #endif
    }
    
    /// Returns a `SKRGBARepresentation` representing the color.
    var rgbaRepresentation : SKRGBARepresentation {
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
        
        return SKRGBARepresentation(red: clamp(red), green: clamp(green), blue: clamp(blue), alpha: clamp(alpha))
    }
    
    private func clamp(_ c: CGFloat) -> CGFloat {
        max(0, min(1, c))
    }
    
    /// Returns a `SK8BitRGBARepresentation` representing the color.
    var bitRGBARepresentation : SK8BitRGBARepresentation {
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
        
        return SK8BitRGBARepresentation(red : UInt8(clamp(red) * 255), green : UInt8(clamp(green) * 255), blue : UInt8(clamp(blue) * 255), alpha : UInt8(clamp(alpha) * 255))
    }
    
    /// Returns a `SKHSLARepresentation` representing the color.
    var HSLARepresentation : SKHSLARepresentation {
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
        
        return SKHSLARepresentation(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: alpha
        )
    }
    
    /// Initializes and returns a color object using the specified `SKRGBARepresentation`.
    convenience init(representation : SKRGBARepresentation) {
        self.init(intermediateDisplayP3Red: representation.red,
                  green: representation.green,
                  blue: representation.blue,
                  alpha: representation.alpha)
    }
    
    /// Initializes and returns a color object using the specified `SK8BitRGBARepresentation`.
    convenience init(representation : SK8BitRGBARepresentation) {
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
    convenience init(representation: SKHSLARepresentation) {
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
#endif
