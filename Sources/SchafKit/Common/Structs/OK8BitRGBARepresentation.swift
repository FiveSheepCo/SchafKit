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

/// A color representation containing 8-bit representations of the `red`, `blue`, `green` and `alpha` values.
public struct OK8BitRGBARepresentation : Equatable, Codable {
    public let red : UInt8
    public let green : UInt8
    public let blue : UInt8
    public let alpha : UInt8
    
    /// Initializes and returns a `UIColor` object using the specified `OK8BitRGBARepresentation`.
    public var color : UIColor {
        return UIColor(representation: self)
    }
    
    /// Initializes and returns a `OK8BitRGBARepresentation` object.
    public init(red : UInt8, green : UInt8, blue : UInt8, alpha : UInt8 = 255) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    /// Initializes and returns a `OK8BitRGBARepresentation` object.
    public init(representation : OKRGBARepresentation) {
        self.red = UInt8(representation.red * 255)
        self.green = UInt8(representation.green * 255)
        self.blue = UInt8(representation.blue * 255)
        self.alpha = UInt8(representation.alpha * 255)
    }
    
    public static func ==(left : OK8BitRGBARepresentation, right : OK8BitRGBARepresentation) -> Bool {
        return OKRGBARepresentation(bitRepresentation: left) == OKRGBARepresentation(bitRepresentation: right)
    }
}
