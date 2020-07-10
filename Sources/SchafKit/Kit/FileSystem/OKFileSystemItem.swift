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

private let fileSystem = FileManager.default

/// An item in the filesystem.
public class OKFileSystemItem {
    /// The path of the receiver.
    public let path : String
    
    /// The url of the receiver.
    public var url : URL {
        return URL(fileURLWithPath: path)
    }
    
    /// Whether the receiver exists in the file system.
    public var exists : Bool {
        var isDirectory : ObjCBool = false
        if fileSystem.fileExists(atPath: path, isDirectory: &isDirectory) {
            return isDirectory.boolValue != (self is OKFile)
        }
        return false
    }
    
    internal init (path : String) {
        self.path = path
    }
}
