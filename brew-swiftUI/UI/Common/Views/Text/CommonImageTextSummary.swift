//
//  CommonImageTextSummary.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 28/10/2022.
//

import SwiftUI

struct CommonImageTextSummary: View {
    // MARK: - Properties
    @ScaledMetric private var size: CGFloat = 1

    let iconName: String
    let primaryText: String
    let secondaryText: String
    let iconTintColor: Color
    let iconSize: CGFloat
    let primaryColor: Color
    let secondaryColor: Color

    // MARK: - Init
    init(
        iconName: String,
        primaryText: String,
        secondaryText: String,
        iconTintColor: Color,
        iconSize: CGFloat = Constants.smallIconSize,
        primaryColor: Color = .label,
        secondaryColor: Color = .secondaryLabel) {
        self.iconName = iconName
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.iconTintColor = iconTintColor
        self.iconSize = iconSize
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }

    // MARK: - Views
    var body: some View {
        Label {
            CommonTextSummary(
                primaryText: primaryText,
                secondaryText: secondaryText,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor
            )
        } icon: {
            Image(systemName: iconName)
                .styleImage(
                    width: size * iconSize,
                    height: size * iconSize,
                    foregroundStyle: iconTintColor
                )
        }
        .labelStyle(
            .centeredImage()
        )
    }
}

struct CommonImageTextSummary_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            CommonImageTextSummary(
                iconName: SFSymbol.mug.title,
                primaryText: "This is a common image text summary",
                secondaryText: "This is a common image text summary, This is a common image text summary",
                iconTintColor: .red
            )
            CommonImageTextSummary(
                iconName: SFSymbol.circle.title,
                primaryText: "This is a common image text summary",
                secondaryText: "This is a common image text summary, This is a common image text summary",
                iconTintColor: .red
            )
        }
        .padding(Padding.screen)
    }
}
