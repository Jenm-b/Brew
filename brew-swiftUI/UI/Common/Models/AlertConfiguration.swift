//
//  AlertConfiguration.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 29/08/2022.
//

import SwiftUI

struct AlertConfiguration : Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let primaryButton: Alert.Button
    let secondaryButton: Alert.Button?

    init(title: String = "",
         message: String,
         primaryButton: Alert.Button = .default(Text("Ok")),
         secondaryButton: Alert.Button? = nil) {
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }
}

extension AlertConfiguration {
    static func item(forType type: AlertType, action: (() -> Void)? = {}) -> Self {
        switch type {
        case .deleteWarning(let drinks):
            let isMultipleDrinks = drinks.count > 1
            let drinkDescription = isMultipleDrinks ? "Drinks" : "\(drinks.first!.user)'s \(drinks.first!.name.rawValue)"
            return AlertConfiguration(
                title: "Are you sure you want to delete \(drinkDescription)?",
                message: drinkDescription + Constants.space + "will be deleted from your drink list",
                primaryButton: .destructive(Text("Delete"), action: action),
                secondaryButton: .cancel()
            )
        case .genericError(let error):
            return AlertConfiguration(message: error.localizedDescription)
        case .serviceError(let error):
            return AlertConfiguration(title: "Service Error", message: error.localizedDescription)
        case .generic:
            return AlertConfiguration(message: "Opps an error has occurred.")
        }
    }
}
