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
#else
    import UIKit
#endif

/// A color representation containing representations of the `hue`, `saturation`, `brightness` and `alpha` values.
public struct OKHSLARepresentation : Equatable {
    public var hue : CGFloat
    public var saturation : CGFloat
    public var brightness : CGFloat
    public var alpha : CGFloat
    
    /// Initializes and returns a `UIColor` object using the specified `OKHSLARepresentation`.
    public var color : UIColor {
        return UIColor(representation: self)
    }
    
    public static func ==(left : OKHSLARepresentation, right : OKHSLARepresentation) -> Bool {
        return abs(left.hue - right.hue) < 0.01 && abs(left.saturation - right.saturation) < 0.01 && abs(left.brightness - right.brightness) < 0.01 && abs(left.alpha - right.alpha) < 0.01
    }
}
