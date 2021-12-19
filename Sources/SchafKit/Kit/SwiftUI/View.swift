//
//  File.swift
//  
//
//  Created by Jann Schafranek on 05.04.21.
//

import Foundation
import SwiftUI

public extension View {
    
    func onRender(perform: OKBlock) -> Self {
        perform()
        return self
    }
    
    @available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 11.0, *)
    func sizeReader(updateSize: @escaping (CGSize) -> Void) -> some View {
        self
            .background(
                GeometryReader(content: { geometry in
                    Rectangle().fill(Color.clear)
                        .onAppear(perform: {
                            updateSize(geometry.size)
                        })
                        .onChange(of: geometry.size, perform: { size in
                            updateSize(size)
                        })
                })
            )
    }
    
    @available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *)
    func onAppearAndChange<V>(of value: V, perform action: @escaping (V) -> Void) -> some View where V : Equatable {
        self
            .onAppear {
                action(value)
            }
            .onChange(of: value, perform: action)
    }
    
    #if !os(macOS)
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    #endif
}

#if !os(macOS)
private struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
#endif

// This can be used to make RoundedCorners work on macOS when required. NSBezierPath doesn't support this though, so it would have to be drawn by hand. 🙄
//#if os(macOS)
//private typealias UIBezierPath = NSBezierPath
//public struct UIRectCorner: OptionSet {
//    public let rawValue: UInt
//
//    public init(rawValue: UInt) {
//        self.rawValue = rawValue
//    }
//
//    public static let topLeft      = UIRectCorner(rawValue: 1 << 0)
//    public static let topRight     = UIRectCorner(rawValue: 1 << 1)
//    public static let bottomLeft   = UIRectCorner(rawValue: 1 << 2)
//    public static let bottomRight  = UIRectCorner(rawValue: 1 << 3)
//
//    public static var allCorners: UIRectCorner {
//        [.topLeft, .topRight, .bottomLeft, .bottomRight]
//    }
//}
//#endif
