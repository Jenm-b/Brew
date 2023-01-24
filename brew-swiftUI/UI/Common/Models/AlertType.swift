//
//  AlertType.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 17/11/2022.
//

import Foundation

enum AlertType {
    case deleteWarning([Drink])
    case genericError(LocalizedError)
    case serviceError(Error)
    case generic
}
