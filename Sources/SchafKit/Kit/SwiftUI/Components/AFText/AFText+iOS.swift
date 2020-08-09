//  Copyright (c) 2020 Quintschaf GbR
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SwiftUI

#if os(iOS)
import UIKit

public struct AFText: View {
    @State var text: String
    @State var arguments: [String]
    @State var height: CGFloat = 0
    @State var width: CGFloat = 0
    
    public init(_ text: String, arguments: [String] = []) {
        self._text = State(initialValue: text)
        self._arguments = State(initialValue: arguments)
    }
    
    public var body: some View {
        AFTextInternal(text: $text, arguments: $arguments, height: $height, width: $width)
            .frame(width: width, height: height)
    }
}

struct AFTextInternal: UIViewRepresentable {
    @Binding var text: String
    @Binding var arguments: [String]
    @Binding var height: CGFloat
    @Binding var width: CGFloat
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = text.localized.markdowned(with: arguments)
        Timer.scheduledTimer(withTimeInterval: 0.01) {
            uiView.sizeToFit()
            height = uiView.frame.size.height + 4
            width = uiView.frame.size.width
        }
    }
}

#endif

@available(macOS 10.16, *)
struct AFText_Previews: PreviewProvider {
    static var previews: some View {
        AFText("test *toast* _toasty_ *_test*ing_")
    }
}
