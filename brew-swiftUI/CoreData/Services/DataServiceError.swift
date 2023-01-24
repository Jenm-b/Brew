//
//  ServiceError.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 06/07/2022.
//

import Foundation

// MARK: - Errors
enum DataServiceError: LocalizedError {
    case notFound
    case notSaved
    case notDeleted
}

extension DataServiceError {
    public var errorDescription: String? {
        var keyWord: String

        switch self {
        case .notFound:
            keyWord = "found"
        case .notSaved:
            keyWord = "saved"
        case .notDeleted:
            keyWord = "deleted"
        }

        return "Entity could not be \(keyWord)"
    }
}
