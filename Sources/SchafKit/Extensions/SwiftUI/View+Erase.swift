#if os(OSX) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation
import SwiftUI

extension View {
    func erase() -> AnyView {
        AnyView(self)
    }
}
#endif
