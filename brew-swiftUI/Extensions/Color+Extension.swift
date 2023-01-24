//
//  Color+Extension.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 15/11/2022.
//

import SwiftUI


extension Color {
    /// Wrapped UIKit UIColors
    static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
    static let secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)

    static let lightText = Color(UIColor.lightText)
    static let darkText = Color(UIColor.darkText)

    static let label = Color(UIColor.label)
    static let secondaryLabel = Color(UIColor.secondaryLabel)
    static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    static let quaternaryLabel = Color(UIColor.quaternaryLabel)

    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)

    // MARK: - Custom Colors
    static let error: Color = Color("Error")
    static let primaryTheme =  Color("NewAccent")
    static let pastelBlue =  Color("PastelBlueColor")
    static let textOnPrimary = Color("TextOnPrimary")

    // MARK: - Gradients
    static let rustGradient = LinearGradient(
        colors: [Color("LightRust"), Color("Rust"), Color("DarkRust")],
        startPoint: .bottomTrailing,
        endPoint: .topLeading
    )

    static let greenGradient = LinearGradient(
        colors: [Color("LimeGreen"), Color("DarkGreen"), Color("MossGreen")],
        startPoint: .bottomTrailing,
        endPoint: .topLeading
    )


    static let primaryGradient = LinearGradient(
        colors: [Color.primaryTheme, Color("LightNavy"), Color("Navy"), Color("DarkNavy")],
        startPoint: .bottomTrailing,
        endPoint: .topLeading
    )
}

