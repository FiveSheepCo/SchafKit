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

public extension Data {
    
    /// Initialize data with secure random numbers.
    ///
    /// - Parameter count: The number of random bytes.
    init (randomWith count : Int) {
        var bytes = [Int8](repeating: 0, count: count)
        
        _ = SecRandomCopyBytes(kSecRandomDefault, count, &bytes)
        
        self.init(bytes: &bytes, count: count)
    }
    
    /// Append data to this instance, creating a new `Data` instance.
    ///
    /// - Parameter data: The `Data` instance to be appended.
    /// - Returns: The combined data.
    func appending(_ data : Data) -> Data {
        var result = self
        
        result.append(data)
        
        return result
    }
    
    /// Appends the receiver to the file at the given url.
    func append(to fileURL: URL) throws {
        let manager = FileManager.default
        if manager.fileExists(atPath: fileURL.path) {
            if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
                defer {
                    fileHandle.closeFile()
                }
                fileHandle.seekToEndOfFile()
                fileHandle.write(self)
            } else {
                try write(to: fileURL, options: .atomic)
            }
        } else {
            FileManager.default.createFile(atPath: fileURL.path, contents: self, attributes: nil)
        }
    }
}
