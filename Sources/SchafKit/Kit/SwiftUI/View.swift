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
    
    @available(iOS 14.0, *)
    func onAppearAndChange<V>(of value: V, perform action: @escaping (V) -> Void) -> some View where V : Equatable {
        self
            .onAppear {
                action(value)
            }
            .onChange(of: value, perform: action)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

private struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
