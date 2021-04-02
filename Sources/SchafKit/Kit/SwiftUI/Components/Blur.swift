//
//  SwiftUIView.swift
//  
//
//  Created by Jann Schafranek on 02.04.21.
//

#if os(iOS) || os(tvOS)

import SwiftUI
import UIKit

/// A native blur effect that can be used as background.
public struct Blur: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    public init(_ style: UIBlurEffect.Style) {
        self.style = style
    }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

#endif
