//
//  SearchBar.swift
//
//  Created by Marco Quinten on 13.07.20.
//
//  Borrowed from this StackOverflow answer:
// https://stackoverflow.com/questions/56490963/how-to-display-a-search-bar-with-swiftui/58473985#58473985
//

import Foundation
import SwiftUI

#if os(iOS)
fileprivate extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

fileprivate struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

fileprivate extension View {
    func resignKeyboardOnDragGesture() -> some View {
        modifier(ResignKeyboardOnDragGesture())
    }
}

public struct SearchBar: View {
    @Binding private var searchText: String
    @State private var showCancelButton: Bool = false
    
    private var onCommit: () -> Void = {}
    
    public init(searchText: Binding<String>, onCommit: @escaping () -> Void = {}) {
        self._searchText = searchText
        self.onCommit = onCommit
    }
    
    public var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                // Search text field
                ZStack (alignment: .leading) {
                    if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                        Text("Search")
                    }
                    TextField("", text: $searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: onCommit).foregroundColor(.primary)
                }
                // Clear button
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary) // For magnifying glass and placeholder test
            .background(Color(.tertiarySystemFill))
            .cornerRadius(10.0)
            
            if showCancelButton  {
                // Cancel button
                Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
    }
}
#endif
