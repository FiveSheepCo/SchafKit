import Foundation

private let fileSystem = FileManager.default
private let slash = "/"

/// A dictionary representation.
public class SKDirectory : SKFileSystemItem {
    /// The Bundle directory.
    public static let bundle = SKDirectory(path : Bundle.main.bundlePath)
    
    /// The `Library` directory.
    public static let library = SKDirectory(path: fileSystem.urls(for: .libraryDirectory, in: .userDomainMask).first!.relativePath)
    /// The `Library/ApplicationSupport` directory.
    public static let applicationSupport = SKDirectory(path: fileSystem.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.relativePath)
    /// The `Library/Caches` directory.
    public static let caches = SKDirectory(path: fileSystem.urls(for: .cachesDirectory, in: .userDomainMask).first!.relativePath)
    
    /// The `Documents` directory.
    public static let documents = SKDirectory(path: fileSystem.urls(for: .documentDirectory, in: .userDomainMask).first!.relativePath)
    /// The `Documents/Inbox` directory.
    public static let inbox = documents.directoryByAppending(path: "Inbox")
    
    /// Returns the directory for the specified app group, if it exists.
    public static func appGroupDirectory(forGroupNamed name : String) -> SKDirectory? {
        guard let url = fileSystem.containerURL(forSecurityApplicationGroupIdentifier: name) else {
            return nil
        }
        return SKDirectory(url: url, createIfNonexistant: false)
    }
    
    // TODO: Make this `SKDirectory` and `SKFile`
    /// The contents of the receiver as strings.
    public var contents : [String] {
        return (try? fileSystem.contentsOfDirectory(atPath: self.path)) ?? []
    }
    
    /// Returns a new `SKDirectory` with the specified path.
    ///
    /// - parameter createIfNonexistant: Whether a directory should be created (with intermediate directories) at that path if it doesn't already exist.
    public init (path : String, createIfNonexistant : Bool = false) {
        super.init(path: path.removingOccurancesAtEnd(of: slash))
        
        if createIfNonexistant && !exists {
            _ = create()
        }
    }
    
    /// Returns a new `SKDirectory` with the specified url.
    public convenience init (url : URL, createIfNonexistant : Bool = false) {
        self.init(path: url.relativePath, createIfNonexistant: createIfNonexistant)
    }
    
    /// Creates the receiver in the file system.
    @discardableResult
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
    @discardableResult
    public func save(data : Data, at path : String) -> Bool {
        do {
            try data.write(to: URL(fileURLWithPath: _getPath(at: path)))
        } catch let err {
            print("Data Save Error:", err)
            return false
        }
        return true
    }
    
    /// Appends the utf8 representation of the given string to the file at the given path.
    public func append(_ string: String, at path: String) {
        try! string.appendToURL(to: _getPath(at: path))
    }
    
    /// Appends the given data to the file at the given path.
    public func append(_ data: Data, at path: String) {
        try! data.append(to: _getPath(at: path))
    }
    
    /// Deletes the file at the given path, if it exists.
    public func delete(at path : String) {
        do {
            try fileSystem.removeItem(atPath: _getPath(at: path))
        } catch let err {
            print("File Deletion Error:", err)
        }
    }
    
    /// Deletes the file at the given path, if it exists.
    public func deleteRecursively(at path : String) {
        do {
            let newPath = _getPath(at: path)
            var isDirectory: ObjCBool = false
            fileSystem.fileExists(atPath: newPath, isDirectory: &isDirectory)
            if isDirectory.boolValue {
                for content in try fileSystem.contentsOfDirectory(atPath: newPath) {
                    SKDirectory(path: newPath).deleteRecursively(at: content)
                }
            }
            try fileSystem.removeItem(atPath: newPath)
        } catch let err {
            print("File Deletion Error:", err)
        }
    }
    
    /// Returns a new `SKDirectory` by appending the path to the receiver's path.
    public func directoryByAppending(path : String, createIfNonexistant : Bool = false) -> SKDirectory {
        return SKDirectory(path: _getPath(at: path), createIfNonexistant: createIfNonexistant)
    }
    
    private func _getPath(at path : String) -> String {
        return self.path + slash + path.removingOccurancesAtStart(of: slash)
    }
}
