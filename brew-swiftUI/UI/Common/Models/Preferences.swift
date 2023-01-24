//
//  Preferences.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 28/10/2022.
//

import SwiftUI
import Combine

class Preferences: ObservableObject {
    // MARK: - Wrapped Properties
    @AppStorage(StorageKey.colorScheme) var currentColorScheme: AppTheme = .system
    @AppStorage(StorageKey.showWelcomeScreen) var showWelcomeScreen: Bool = true

    @Published var currentAppIconName: String = UIApplication.shared.alternateIconName ?? AppIconTheme.medium.iconName

    // MARK: - Properties
    let availableThemes: [AppTheme] = AppTheme.allCases
    let availableIcons: [AppIconTheme] = AppIconTheme.allCases
}

// MARK: - Constants
private extension Preferences {

    enum StorageKey {
        static let showWelcomeScreen = "shouldShowWelcomeScreen"
        static let colorScheme = "colorScheme"
    }
}

// MARK: - Errors
enum AppIconError: LocalizedError {
    case notSupported
    case notSaved

    var localizedDescription: String {
        switch self {
        case .notSupported:
            return "Application does not support alternate icons."
        case .notSaved:
            return "Oops. App Icon could not be changed. Please try again."
        }
    }
}
