//
//  File.swift
//  
//
//  Created by Jann Schafranek on 05.03.21.
//

#if os(iOS)
import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

#endif
