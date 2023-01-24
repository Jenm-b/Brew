//
//  ValidationResult.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 29/08/2022.
//

import Foundation

enum ValidationResult: Equatable, Hashable {
    case valid(Validation)
    case invalid(Validation)
}

enum Validation: Hashable, Equatable {
    case empty
    case required
    case maxCharacters(Int)
}

extension Validation: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .empty:
            return "Oops. This field is required."
        case .required:
            return "Oops. This field is required."
        case .maxCharacters(let maxCharacters):
            return "Oops. Too many characters. \(maxCharacters) maximum characters allowed."
        }
    }
}
