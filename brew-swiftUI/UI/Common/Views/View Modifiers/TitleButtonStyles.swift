//
//  TitleButtonStyles.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 30/11/2022.
//

import SwiftUI

struct ActionButtonStyle: ButtonStyle {
    // MARK: - Properties
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.colorScheme) private var colorScheme

    private let titleColor: Color
    private let backgroundColor: Color
    private let cornerRadius: CGFloat

    private var shadowColor: Color {
        colorScheme == .light ? Color.label.opacity(Constants.shadowAlpha): .clear
    }

    // MARK: - Init
    init(
         titleColor: Color = .textOnPrimary,
         backgroundColor: Color = .primaryTheme,
         cornerRadius: CGFloat = Constants.buttonRadius) {
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
    }

    // MARK: - View
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .fontWeight(.semibold)
            .foregroundColor(titleColor)
            .clipRoundedRectangle(
                cornerRadius,
                fill: backgroundColor,
                padding: Padding.item
            )
            .opacity(isEnabled ? 1 : 0.3)
            .shadow(
                color: shadowColor,
                radius: 5, x: 5, y: 5
            )
    }
}
