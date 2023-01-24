//
//  AppIcon.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 21/10/2022.
//

enum AppIconTheme: String, CaseIterable {
    case medium
    case black
    case extraStrong = "extra strong"
    case strongish
    case water
    case weakButStrong = "weak but strong"
    case matcha
    case weakButMedium = "weak but medium"

    var iconName: String {
        switch self {
        case .medium:
            return Constants.defaultAppImageName
        case .black:
            return "BlackWithMediumDrop"
        case .extraStrong:
            return "ExtraStrongWithWhiteDrop"
        case .strongish:
            return "StrongWithWhiteDrop"
        case .water:
            return "WeakWithBlueDrop"
        case .weakButStrong:
            return "WeakWithExtraStrongDrop"
        case .matcha:
            return "WeakWithMachaDrop"
        case .weakButMedium:
            return "WeakWithMediumDrop"
        }
    }

    var previewIconName: String {
        return iconName + Constants.preview
    }

    var title: String {
        return rawValue
    }
}

private extension AppIconTheme {
     enum Constants {
        static let preview = "_Preview"
        static let defaultAppImageName = "AppIcon"
    }
}
