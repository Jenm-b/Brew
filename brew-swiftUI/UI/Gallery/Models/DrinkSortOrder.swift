//
//  DrinkSortOrder.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 20/08/2022.
//

enum DrinkSortOrder: String, Hashable, CaseIterable {
    case name
    case drink

    var title: String {
        return "Sort by \(rawValue.capitalized)"
    }

    var icon: SFSymbol {
        switch self {
        case .name:
            return .friend
        case .drink:
            return .mug
        }
    }
}
