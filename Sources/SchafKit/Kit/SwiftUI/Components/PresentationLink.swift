#if os(OSX) || os(iOS) || os(tvOS) || os(watchOS)
import SwiftUI

/// Sheet presentation button analogue to NavigationLink.
@available(macOS 11.0, *)
public struct PresentationLink<Label, Destination>: View
where Label: View, Destination: View {
    @State var isPresented = false
    
    var destination: Destination
    var label: () -> Label
    var withNavigationView: Bool
    
    public init(destination: Destination, label: @escaping () -> Label, withNavigationView: Bool = true) {
        self.destination = destination
        self.label = label
        self.withNavigationView = withNavigationView
    }
    
    public var body: some View {
        Button(
            action: {
                self.isPresented.toggle()
            },
            label: label
        ).sheet(isPresented: $isPresented) {
            if self.withNavigationView {
                #if os(watchOS)
                if #available(watchOS 7.0, *) {
                    NavigationView {
                        self.destination
                    }
                } else {
                    self.destination
                }
                #else
                NavigationView {
                    self.destination
                }
                #endif
            } else {
                self.destination
            }
        }
    }
}
#endif
