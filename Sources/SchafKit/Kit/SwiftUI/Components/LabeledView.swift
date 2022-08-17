#if os(OSX) || os(iOS) || os(tvOS) || os(watchOS)
import SwiftUI

public struct LabeledView<A: View, B: View>: View {
    let title: A
    let content: B
    
    public init(_ title: A, content: () -> B) {
        self.title = title
        self.content = content()
    }
    
    public var body: some View {
        HStack {
            title.multilineTextAlignment(.leading)
            Spacer()
            content.multilineTextAlignment(.trailing)
        }
    }
}

struct LabeledView_Previews: PreviewProvider {
    static var previews: some View {
        LabeledView(Text("Name")) {
            EmptyView()
        }
    }
}
#endif
