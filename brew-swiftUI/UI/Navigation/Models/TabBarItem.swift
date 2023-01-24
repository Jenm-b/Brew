//
//  TabBarItem.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 19/09/2022.
//

import SwiftUI

enum TabBarItem: String, CaseIterable, Identifiable {
    case drinks
    case settings

    var id: String {
        return rawValue
    }

    var title: String {
        return rawValue.capitalized
    }

    var icon: SFSymbol {
        switch self {
        case .settings:
            return .gear
        case .drinks:
            return .list
        }
    }

    @ViewBuilder
    var routerView: some View {
        switch self {
        case .settings:
            SettingsRouterView()
        case .drinks:
            DrinkRouterView()
        }
    }
}
