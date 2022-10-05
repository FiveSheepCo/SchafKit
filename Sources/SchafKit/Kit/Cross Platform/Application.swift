import Foundation
#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

public class Application {
    
    private init() {}
    
    public static func open(url: String, completionHandler: @escaping (Bool) -> Void = { _ in }) {
        guard let url = URL(string: url) else {
            print("`Application.open(url: String)` received a string that does not produce a valid URL:", url)
            completionHandler(false)
            return
        }
        
        #if canImport(UIKit)
        UIApplication.shared.open(url, completionHandler: completionHandler)
        #else
        completionHandler(NSWorkspace.shared.open(url))
        #endif
    }
    
    public static func openSettings() {
        #if canImport(UIKit)
        UIApplication.shared.openSettings()
        #else
        NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:")!)
        #endif
    }
}
