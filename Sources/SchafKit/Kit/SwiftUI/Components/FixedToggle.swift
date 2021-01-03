//
//  SwiftUIView.swift
//  
//
//  Created by Marco Quinten on 03.01.21.
//

#if os(iOS)

import SwiftUI

struct FixedToggle: View {
    @Binding var isOn: Bool
    
    init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }
    
    var body: some View {
        Toggle(isOn: $isOn, label: { EmptyView() })
            .frame(maxWidth: 49)
            .offset(x: -5)
    }
}

#endif
