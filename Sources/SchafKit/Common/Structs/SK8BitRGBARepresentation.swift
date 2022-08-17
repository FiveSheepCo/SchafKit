#if os(OSX) || os(iOS) || os(tvOS)
#if os(OSX)
    import AppKit
#else
    import UIKit
#endif

/// A color representation containing 8-bit representations of the `red`, `blue`, `green` and `alpha` values.
public struct SK8BitRGBARepresentation: Equatable, Hashable, Codable {
    public let red : UInt8
    public let green : UInt8
    public let blue : UInt8
    public let alpha : UInt8
    
    /// Initializes and returns a `UIColor` object using the specified `SK8BitRGBARepresentation`.
    public var color : UIColor {
        return UIColor(representation: self)
    }
    
    /// Initializes and returns a `SK8BitRGBARepresentation` object.
    public init(red : UInt8, green : UInt8, blue : UInt8, alpha : UInt8 = 255) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    /// Initializes and returns a `SK8BitRGBARepresentation` object.
    public init(representation : SKRGBARepresentation) {
        self.red = UInt8(representation.red * 255)
        self.green = UInt8(representation.green * 255)
        self.blue = UInt8(representation.blue * 255)
        self.alpha = UInt8(representation.alpha * 255)
    }
    
    public static func ==(left : SK8BitRGBARepresentation, right : SK8BitRGBARepresentation) -> Bool {
        return SKRGBARepresentation(bitRepresentation: left) == SKRGBARepresentation(bitRepresentation: right)
    }
}
#endif
