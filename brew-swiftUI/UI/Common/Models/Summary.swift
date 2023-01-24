//
//  Summary.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 28/10/2022.
//

import SwiftUI

protocol Summarise {
    var icon: SFSymbol? { get }
    var iconTint: Color { get }
    var primaryText: String { get }
    var secondaryText: String { get }
}

struct Summary: Summarise, Hashable {
    let icon: SFSymbol?
    let iconTint: Color
    let primaryText: String
    let secondaryText: String

    init(icon: SFSymbol? = nil,
         iconTint: Color = .clear,
         primary: String,
         secondary: String) {
        self.icon = icon
        self.iconTint = iconTint
        self.primaryText = primary
        self.secondaryText = secondary
    }
}
