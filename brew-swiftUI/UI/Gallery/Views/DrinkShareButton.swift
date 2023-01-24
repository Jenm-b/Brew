//
//  DrinkShareButton.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 28/11/2022.
//

import SwiftUI

struct DrinkShareButton: View {
    // MARK: - Properties
    let drink: Drink

    private var drinkersName: String {
     "\(drink.user.capitalized)'s Drink"
    }

    private var drinkDetails: String {
        let milkDescriptionSuffix = drink.milk == .none ? "" : " milk"
        let drinkDescription = "\(drinkersName) - \(drink.name.rawValue) with \(drink.milk.rawValue)\(milkDescriptionSuffix) and \(drink.sweetener.rawValue)."
        return "\(drinkDescription)"
    }

    // MARK: - View
    var body: some View {
        ShareLink(
            item: drinkDetails,
            subject: Text(drinkersName),
            message: Text(drinkDetails)
        )
    }
}

struct DrinkShareButton_Previews: PreviewProvider {
    @State static var userPreferences = Preferences()

    static var previews: some View {
        Group {
            Text("Press me baby")
                .clipRoundedRectangle(fill: Color.primaryTheme, padding: 10)
                .contextMenu {
                    DrinkShareButton(drink: Drink.mockDrink)
                }
        }
    }
}
