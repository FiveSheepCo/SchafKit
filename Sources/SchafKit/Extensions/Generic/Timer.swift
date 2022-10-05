import Foundation
#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

public extension Timer {
    
    @available(tvOS 10.0, *)
    @available(OSX 10.12, *)
    @discardableResult
    static func scheduledTimer(withTimeInterval timeInterval : TimeInterval, block : @escaping SKBlock) -> Timer {
        scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { (_) in
            block()
        })
    }
}
#endif
