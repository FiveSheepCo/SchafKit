#if os(OSX) || os(iOS) || os(tvOS)
#if os(OSX)
    import AppKit
#else
    import UIKit
#endif

/// A color representation containing representations of the `hue`, `saturation`, `brightness` and `alpha` values.
public struct SKHSLARepresentation : Equatable, Codable {
    public var hue : CGFloat
    public var saturation : CGFloat
    public var brightness : CGFloat
    public var alpha : CGFloat
    
    /// Initializes and returns a `UIColor` object using the specified `SKHSLARepresentation`.
    public var color : UIColor {
        return UIColor(representation: self)
    }
    
    public static func ==(left : SKHSLARepresentation, right : SKHSLARepresentation) -> Bool {
        return abs(left.hue - right.hue) < 0.01 && abs(left.saturation - right.saturation) < 0.01 && abs(left.brightness - right.brightness) < 0.01 && abs(left.alpha - right.alpha) < 0.01
    }
}
#endif
