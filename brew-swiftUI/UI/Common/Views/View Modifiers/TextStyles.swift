//
//  TextStyles.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 26/08/2022.
//

import SwiftUI

struct Primary: ViewModifier {
    // MARK: - Properties
    let color: Color

    // MARK: - Text Style
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(color)
    }
}

struct Title: ViewModifier {
    // MARK: - Properties
    let color: Color

    // MARK: - Text Style
    func body(content: Content) -> some View {
        content
            .font(
                .system(.largeTitle, design: .rounded)
                .weight(.bold)
            )
            .foregroundColor(color)
    }
}

struct Secondary: ViewModifier {
    // MARK: - Properties
    let color: Color

    // MARK: - Text Style
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(color)
    }
}
