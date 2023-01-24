//
//  Alert+Extension.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 31/08/2022.
//

import SwiftUI

extension Alert {
    init(alertConfiguration configuration: AlertConfiguration) {
        if let secondaryButton = configuration.secondaryButton {
            self.init(
                title: Text(configuration.title),
                message: Text(configuration.message),
                primaryButton: configuration.primaryButton,
                secondaryButton: secondaryButton
            )
        } else {
            self.init(
                title: Text(configuration.title),
                message: Text(configuration.message),
                dismissButton: configuration.primaryButton
            )
        }
    }
}
