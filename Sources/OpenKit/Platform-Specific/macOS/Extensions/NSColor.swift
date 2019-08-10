//  Copyright (c) 2015 - 2019 Jann Schafranek
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

#if canImport(AppKit)
import AppKit

public extension NSColor {
    
    /// Returns the system color used for displaying text on a light background.
    class var darkText : NSColor {
        return black
    }
    
    /// Returns the system color used for displaying text on a dark background.
    class var lightText : NSColor {
        return NSColor(white: 1, alpha: 0.6)
    }
    
    /// Returns the system color used for the background of a grouped table.
    class var groupTableViewBackground : NSColor {
        return NSColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1)
    }
    
    /// The Core Image color associated with the receiver.
    var ciColor : CIColor {
        return CIColor(cgColor: self.cgColor)
    }
}
#endif
