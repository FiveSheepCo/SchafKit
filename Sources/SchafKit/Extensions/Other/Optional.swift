//
//  Optional.swift
//  MyKeyboard
//
//  Created by Marco Quinten on 02.01.21.
//

import Foundation

extension Optional: Identifiable where Wrapped: Identifiable {
    public var id: some Hashable {
        return self?.id
    }
}
