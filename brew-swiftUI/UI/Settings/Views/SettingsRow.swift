//
//  SettingsRow.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 17/11/2022.
//

import SwiftUI

struct SettingsRow<AccessoryContent: View>: View {
    // MARK: - Wrapped Properties
    @ScaledMetric var size: CGFloat = 1

    // MARK: - Properties
    private let title: String
    private let icon: SFSymbol
    private let iconTintColor: Color
    private let accessoryContent: AccessoryContent

    // MARK: - Init
    init(
        title: String,
        icon: SFSymbol,
        iconTintColor: Color,
        @ViewBuilder accessoryContent: () -> AccessoryContent
    ) {
        self.accessoryContent = accessoryContent()
        self.title = title
        self.icon = icon
        self.iconTintColor = iconTintColor
    }

    // MARK: - Views
    var body: some View {
        primaryContent
    }

    @ViewBuilder
    var primaryContent: some View {
        Label {
            HStack(spacing: Padding.textGap) {
                if !title.isEmpty {
                    Text(title)
                    Spacer()
                }
                accessoryContent
            }
        } icon: {
            Image(symbol: icon)
                .clipImage(
                    RoundedRectangle(cornerRadius: Constants.iconCornerRadius),
                    fill: iconTintColor,
                    width: size * Constants.smallIconSize,
                    height: size * Constants.smallIconSize,
                    padding: Padding.textGap,
                    foregroundStyle: .white
                )
                .symbolVariant(.fill)
        }
    }
}

// MARK: - Helper Init
extension SettingsRow where AccessoryContent == EmptyView {
    /// Content when row does not have an accessory content
    /// e.g. developer information row.
    init(title: String, icon: SFSymbol, iconTintColor: Color) {
        self.init(
            title: title,
            icon: icon,
            iconTintColor: iconTintColor
        ) {
            EmptyView()
        }
    }
}

struct SettingsRow_Previews: PreviewProvider {

    static var previews: some View {
        List {
            SettingsRow(title: "Gimme gimme gimme a drink after midnight", icon: .theme, iconTintColor: .teal)
            SettingsRow(title: "You can brew", icon: .mug, iconTintColor: .pink) {
                Image(symbol: .chevronForward)
            }
            SettingsRow(title: "Dancing macha", icon: .cart, iconTintColor: .brown)
        }
    }
}
