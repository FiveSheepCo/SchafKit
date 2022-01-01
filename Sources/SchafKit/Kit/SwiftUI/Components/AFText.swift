import SwiftUI

@available(macOS 10.16, *)
public struct AFText: View {
    @State var text: String
    @State var arguments: [String]
    
    @Environment(\EnvironmentValues.font) var font
    
    public init(_ text: String, arguments: [String] = []) {
        self._text = State(initialValue: text)
        self._arguments = State(initialValue: arguments)
    }
    
    public var body: some View {
        text.localized.markdownedText(with: font ?? .body, arguments: arguments)
    }
}
