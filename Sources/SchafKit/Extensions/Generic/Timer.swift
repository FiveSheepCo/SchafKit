import Foundation

public extension Timer {
    
    @available(tvOS 10.0, *)
    @available(OSX 10.12, *)
    static func scheduledTimer(withTimeInterval timeInterval : TimeInterval, block : @escaping SKBlock) {
        scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { (_) in
            block()
        })
    }
}
