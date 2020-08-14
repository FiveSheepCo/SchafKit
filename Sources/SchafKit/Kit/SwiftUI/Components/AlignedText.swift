//
//  AlignedText.swift
//  
//
//  Created by Marco Quinten on 11.07.20.
//

import SwiftUI

@available(iOS 14, *)
public struct AlignedText: View {
    private let string: String?
    private let stringKey: LocalizedStringKey?
    private let alignment: TextAlignment
    
    public init(_ string: String, alignment: TextAlignment = .center) {
        self.string = string
        self.stringKey = nil
        self.alignment = alignment
    }
    
    public init(_ key: LocalizedStringKey, alignment: TextAlignment = .center) {
        self.string = nil
        self.stringKey = key
        self.alignment = alignment
    }
    
    public var body: some View {
        HStack {
            if alignment != .leading {
                Spacer()
            }
            if let content = string {
                Text(content)
            } else if let content = stringKey {
                Text(content)
            } else {
                EmptyView()
            }
            if alignment != .trailing {
                Spacer()
            }
        }
    }
}

@available(iOS 14, *)
struct AlignedText_Previews: PreviewProvider {
    static var previews: some View {
        AlignedText("AlignedText")
    }
}
