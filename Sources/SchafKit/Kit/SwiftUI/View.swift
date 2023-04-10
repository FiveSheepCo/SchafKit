#if os(OSX) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation
import SwiftUI
import Combine

// MARK: Additional View Modifiers

public extension View {
    
    func onRender(perform: SKBlock) -> Self {
        perform()
        return self
    }
    
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

// MARK: - onChange for iOS 13

public struct ChangeObserver<V: Equatable>: ViewModifier {
    public init(newValue: V, action: @escaping (V) -> Void) {
        self.newValue = newValue
        self.newAction = action
    }

    private typealias Action = (V) -> Void

    private let newValue: V
    private let newAction: Action

    @State private var state: (V, Action)?

    public func body(content: Content) -> some View {
        if #available(iOS 14, *) {
            assertionFailure("Please don't use this ViewModifer directly and use the `onChange(of:perform:)` modifier instead.")
        }
        return content
            .onAppear()
            .onReceive(Just(newValue)) { newValue in
                if let (currentValue, action) = state, newValue != currentValue {
                    action(newValue)
                }
                state = (newValue, newAction)
            }
    }
}

extension View {
    @_disfavoredOverload
    @ViewBuilder public func onChange<V>(of value: V, perform action: @escaping (V) -> Void) -> some View where V: Equatable {
        if #available(iOS 14, macOS 11, tvOS 14, watchOS 7, *) {
            onChange(of: value, perform: action)
        } else {
            modifier(ChangeObserver(newValue: value, action: action))
        }
    }
}

// MARK: - Rounded Corners

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
#endif
