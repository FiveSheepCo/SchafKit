//
//  File.swift
//  
//
//  Created by Jann Schafranek on 05.03.21.
//

#if os(iOS)
import UIKit

public extension UIDevice {
    var hasNotch: Bool {
        return UIApplication.shared.windows.any { $0.safeAreaInsets.bottom > 0 }
    }
}

#endif
