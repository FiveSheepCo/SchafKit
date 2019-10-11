//
//  File.swift
//  
//
//  Created by Jann Schafranek on 11.10.19.
//

import UIKit

extension OKAlerting {
    public enum Style {
        case alert, actionSheet
        
        #if os(iOS) || os(tvOS)
        var value : UIAlertController.Style {
            switch self {
            case .alert:
                return .alert
            case .actionSheet:
                return .actionSheet
            }
        }
        #endif
    }
}
