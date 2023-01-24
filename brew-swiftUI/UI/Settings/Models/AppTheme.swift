//
//  AppTheme.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 21/10/2022.
//

import SwiftUI

enum AppTheme: String, CaseIterable {
    case dark
    case light
    case system

    var toColorScheme: ColorScheme? {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }

    var label: String {
        return rawValue
    }

    var iconColor: Color {
        switch self {
        case .dark:
            return .black
        case .light:
            return .white
        case .system:
            return .systemBackground
        }
    }
}
