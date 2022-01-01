import Foundation

public extension NSObject {
    
    /**
     Registers the observer object to receive KVO notifications for the key path relative to the object receiving this message.
    
     - Parameters:
       - observer : The object to register for KVO notifications. The observer must implement the key-value observing method `observeValueForKeyPath:ofObject:change:context:`.
       - keyPath : The key path, relative to the object receiving this message, of the property to observe.
    */
    func addObserver(_ observer : NSObject, forKeyPath keyPath : String){
        addObserver(observer, forKeyPath: keyPath, options: [], context: nil)
    }
}
