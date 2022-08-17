#if os(OSX) || os(iOS) || os(tvOS)
#if os(OSX)
    import AppKit
#else
    import UIKit
#endif

/// A color representation containing representations of the `red`, `blue`, `green` and `alpha` values.
public struct SKRGBARepresentation : Equatable, Codable {
    public let red : CGFloat
    public let green : CGFloat
    public let blue : CGFloat
    public let alpha : CGFloat
    
    /// Initializes and returns a `UIColor` object using the specified `SKRGBARepresentation`.
    public var color : UIColor {
        return UIColor(representation: self)
    }
    
    /// Initializes and returns a `SKRGBARepresentation` object.
    public init(red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    /// Initializes and returns a `SKRGBARepresentation` object.
    public init(bitRepresentation : SK8BitRGBARepresentation) {
        self.red = CGFloat(bitRepresentation.red)/255
        self.green = CGFloat(bitRepresentation.green)/255
        self.blue = CGFloat(bitRepresentation.blue)/255
        self.alpha = CGFloat(bitRepresentation.alpha)/255
    }
    
    public static func ==(left : SKRGBARepresentation, right : SKRGBARepresentation) -> Bool {
        return abs(left.red - right.red) < 0.01 && abs(left.green - right.green) < 0.01 && abs(left.blue - right.blue) < 0.01 && abs(left.alpha - right.alpha) < 0.01
    }
}
#endif
