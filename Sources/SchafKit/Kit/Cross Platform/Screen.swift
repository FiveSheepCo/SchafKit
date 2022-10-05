import Foundation
#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

public class Screen {
    public static var main = Screen()
    
    private init() {}
    
    public static var size: CGSize {
        #if canImport(UIKit)
        UIScreen.main.bounds.size
        #else
        (NSScreen.main ?? NSScreen.screens.first)?.frame.size ?? .zero
        #endif
    }
    
    public static var scale: CGFloat {
        #if canImport(UIKit)
        UIScreen.main.scale
        #else
        (NSScreen.main ?? NSScreen.screens.first)?.backingScaleFactor ?? 1
        #endif
    }
}
