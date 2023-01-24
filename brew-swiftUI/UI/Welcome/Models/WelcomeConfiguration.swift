//
//  WelcomeConfiguration.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 02/11/2022.
//

import SwiftUI

struct WelcomeConfiguration {
    let icon: SFSymbol
    let iconTint: Color
    let iconForegroundStyle: Color

    let primaryText: String
    let secondaryText: String

    let summaryPoints: [Summary]

    let buttonText: String

    init(icon: SFSymbol, iconTint: Color, iconForegroundStyle: Color, primary: String, secondary: String, featureItem: [Summary] = [], buttonTitle: String) {
        self.icon = icon
        self.iconTint = iconTint
        self.primaryText = primary
        self.secondaryText = secondary
        self.summaryPoints = featureItem
        self.buttonText = buttonTitle
        self.iconForegroundStyle = iconForegroundStyle
    }
}

extension WelcomeConfiguration {
    static let drinkTitle =
        WelcomeConfiguration(
            icon: .tearDrop,
            iconTint: Strength.mediumToStrong.color,
            iconForegroundStyle: Color.primaryTheme,
            primary: "Welcome to Brew",
            secondary: "This app brings your friends and families drink preferences into one easy to manage place.",
            buttonTitle: "Continue"
        )

    static let drinkKeyFeature = WelcomeConfiguration(
        icon: .sparkles,
        iconTint: .primaryTheme,
        iconForegroundStyle: .textOnPrimary,
        primary: "Awesome Features",
        secondary: "", featureItem: [
            Summary(
                icon: .speedometer,
                iconTint: .green,
                primary: "Quick Creation",
                secondary: "Simply tap the plus icon in the toolbar to create a drink."
            ),
            Summary(
                icon: .text,
                iconTint: .teal,
                primary: "Easy Organising",
                secondary: "View drinks in a list or grid view. Sort drinks by user name and drink type."
            ),
            Summary(
                icon: .friends,
                iconTint: .error,
                primary: "Sharing",
                secondary: "Easily share drinks with friends and family."
            )
        ], buttonTitle: "Lets get Started!")
}
