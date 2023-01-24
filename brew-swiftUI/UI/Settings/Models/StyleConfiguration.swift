//
//  StyleConfiguration.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 21/10/2022.
//

import SwiftUI

// MARK: - Errors
enum AlternateIconError: LocalizedError {
    case notSupported
    case notSaved

    var localizedDescription: String {
        switch self {
        case .notSupported:
            return "Application does not support alternate icons."
        case .notSaved:
            return "Opps. App Icon could not be changed. Please try again."
        }
    }
}
