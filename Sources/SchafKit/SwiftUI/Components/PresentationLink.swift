//
//  PresentationLink.swift
//  
//
//  Created by Marco Quinten on 11.07.20.
//

import SwiftUI

/// Sheet presentation button analogue to NavigationLink.
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
                NavigationView {
                    self.destination
                }
            } else {
                self.destination
            }
        }
    }
}

struct PresentationLink_Previews: PreviewProvider {
    static var previews: some View {
        PresentationLink(destination: EmptyView(), label: { Text("PresentationLink") })
    }
}
