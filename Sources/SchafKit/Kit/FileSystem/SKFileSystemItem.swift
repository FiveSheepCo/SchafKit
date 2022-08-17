#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

private let fileSystem = FileManager.default

/// An item in the filesystem.
public class SKFileSystemItem {
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
            return isDirectory.boolValue != (self is SKFile)
        }
        return false
    }
    
    internal init (path : String) {
        self.path = path
    }
}
#endif
