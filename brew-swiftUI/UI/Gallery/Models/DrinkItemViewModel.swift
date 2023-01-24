//
//  DrinkItemViewModel.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 06/07/2022.
//

struct DrinkItemViewModel {
    let drink: Drink

    var strength: Strength {
        return drink.strength
    }

    var keyDetails: [String] {
        let sweetener = drink.sweetener.rawValue
        var details = [
            "💪 \(strength.rawValue)",
            "🍬 \(sweetener)",
            "🍼 \(drink.milk.rawValue)",
            "\(!drink.caffeinated ? "😴 de" : "🚀 ")caffeinated"
        ]

        if  drink.sweetener != .none {
            details.append(" 🥄\(drink.teaSpoonsSugar) tsp(s) of \(sweetener)")
        }

        return details
    }


    var title: String {
        return "\(drink.user)'s \(drink.name.rawValue.capitalized)"
    }
}
