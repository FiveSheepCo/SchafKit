import Foundation

public extension Data {
    
    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    /// Initialize data with secure random numbers.
    ///
    /// - Parameter count: The number of random bytes.
    init (randomWith count : Int) {
        var bytes = [Int8](repeating: 0, count: count)
        
        _ = SecRandomCopyBytes(kSecRandomDefault, count, &bytes)
        
        self.init(bytes: &bytes, count: count)
    }
    #endif
    
    /// Append data to this instance, creating a new `Data` instance.
    ///
    /// - Parameter data: The `Data` instance to be appended.
    /// - Returns: The combined data.
    func appending(_ data : Data) -> Data {
        var result = self
        
        result.append(data)
        
        return result
    }
    
    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    /// Appends the receiver to the file at the given path.
    func append(to filePath: String) throws {
        if let fileHandle = FileHandle(forWritingAtPath: filePath) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        } else {
            FileManager.default.createFile(atPath: filePath, contents: self, attributes: nil)
        }
    }
    #endif
}
