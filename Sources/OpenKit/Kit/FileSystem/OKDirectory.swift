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

import Foundation

private let fileSystem = FileManager.default
private let slash = "/"

/// A dictionary representation.
public class OKDirectory : OKFileSystemItem {
    /// The Bundle directory.
    public static let bundle = OKDirectory(path : Bundle.main.bundlePath)
    
    /// The `Library` directory.
    public static let library = OKDirectory(path: fileSystem.urls(for: .libraryDirectory, in: .userDomainMask).first!.relativePath)
    /// The `Library/ApplicationSupport` directory.
    public static let applicationSupport = OKDirectory(path: fileSystem.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.relativePath)
    /// The `Library/Caches` directory.
    public static let caches = OKDirectory(path: fileSystem.urls(for: .cachesDirectory, in: .userDomainMask).first!.relativePath)
    
    /// The `Documents` directory.
    public static let documents = OKDirectory(path: fileSystem.urls(for: .documentDirectory, in: .userDomainMask).first!.relativePath)
    /// The `Documents/Inbox` directory.
    public static let inbox = documents.directoryByAppending(path: "Inbox")
    
    /// Returns the directory for the specified app group, if it exists.
    public static func appGroupDirectory(forGroupNamed name : String) -> OKDirectory? {
        guard let url = fileSystem.containerURL(forSecurityApplicationGroupIdentifier: name) else {
            return nil
        }
        return OKDirectory(url: url, createIfNonexistant: false)
    }
    
    // TODO: Make this `OKDirectory` and `OKFile`
    /// The contents of the receiver as strings.
    public var contents : [String] {
        return (try? fileSystem.contentsOfDirectory(atPath: self.path)) ?? []
    }
    
    /// Returns a new `OKDirectory` with the specified path.
    ///
    /// - parameter createIfNonexistant: Whether a directory should be created (with intermediate directories) at that path if it doesn't already exist.
    public init (path : String, createIfNonexistant : Bool = false) {
        super.init(path: path.removingOccurancesAtEnd(of: slash))
        
        if createIfNonexistant && !exists {
            _ = create()
        }
    }
    
    /// Returns a new `OKDirectory` with the specified url.
    public convenience init (url : URL, createIfNonexistant : Bool = false) {
        self.init(path: url.relativePath, createIfNonexistant: createIfNonexistant)
    }
    
    /// Creates the receiver in the file system.
    public func create() -> Bool {
        do {
            try fileSystem.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch let err {
            print("Directory Creation Error:", err)
            return false
        }
    }
    
    /// Returns the contents of the file at the given path, if it exists.
    public func getData(at path : String) -> Data? {
        return fileSystem.contents(atPath: _getPath(at: path))
    }
    
    /// Saves the data to the path.
    public func save(data : Data, at path : String) -> Bool {
        do {
            try data.write(to: URL(fileURLWithPath: _getPath(at: path)))
        } catch let err {
            print("Data Save Error:", err)
            return false
        }
        return true
    }
    
    /// Deletes the file at the given path, if it exists.
    public func delete(at path : String) {
        do {
            try fileSystem.removeItem(atPath: _getPath(at: path))
        } catch let err {
            print("File Deletion Error:", err)
        }
    }
    
    /// Returns a new `OKDirectory` by appending the path to the receiver's path.
    public func directoryByAppending(path : String, createIfNonexistant : Bool = false) -> OKDirectory {
        return OKDirectory(path: _getPath(at: path), createIfNonexistant: createIfNonexistant)
    }
    
    private func _getPath(at path : String) -> String {
        return self.path + slash + path.removingOccurancesAtStart(of: slash)
    }
}
