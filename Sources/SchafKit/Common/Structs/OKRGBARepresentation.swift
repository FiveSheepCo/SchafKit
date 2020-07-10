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

/// A color representation containing representations of the `red`, `blue`, `green` and `alpha` values.
public struct OKRGBARepresentation : Equatable {
    public let red : CGFloat
    public let green : CGFloat
    public let blue : CGFloat
    public let alpha : CGFloat
    
    /// Initializes and returns a `UIColor` object using the specified `OKRGBARepresentation`.
    public var color : UIColor {
        return UIColor(representation: self)
    }
    
    /// Initializes and returns a `OKRGBARepresentation` object.
    public init(red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    /// Initializes and returns a `OKRGBARepresentation` object.
    public init(bitRepresentation : OK8BitRGBARepresentation) {
        self.red = CGFloat(bitRepresentation.red)/255
        self.green = CGFloat(bitRepresentation.green)/255
        self.blue = CGFloat(bitRepresentation.blue)/255
        self.alpha = CGFloat(bitRepresentation.alpha)/255
    }
    
    public static func ==(left : OKRGBARepresentation, right : OKRGBARepresentation) -> Bool {
        return abs(left.red - right.red) < 0.01 && abs(left.green - right.green) < 0.01 && abs(left.blue - right.blue) < 0.01 && abs(left.alpha - right.alpha) < 0.01
    }
}
