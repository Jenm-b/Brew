//
//  Destinations.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 17/08/2022.
//

enum DrinkDestination: Hashable {
    case drinkGallery
    case drinkDetail(Drink? = nil)
}

enum SettingsDestination: Hashable {
    case settings
}
