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

import Foundation

public extension NSMutableAttributedString {
    
    /**
     Adds an attribute with the given name and value to the entire receiver.
     */
    func addAttribute(_ name: NSAttributedString.Key, value : Any){
        addAttribute(name, value: value, range: NSRange(location: 0, length: self.length))
    }
    
    /**
     Removes the named attribute from the characters in the entire receiver.
     */
    func removeAttribute(_ name: NSAttributedString.Key){
        removeAttribute(name, range: NSRange(location: 0, length: self.length))
    }
    
    /**
     Adds the characters of a given string to the end of the receiver.
     */
    func append(_ string: String){
        append(NSAttributedString(string: string))
    }
    
    /**
     Adds the given character to the end of the receiver.
     */
    func append(_ character: Character){
        append(NSAttributedString(string: String(character)))
    }
}
