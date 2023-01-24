//
//  BrowseLayout.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 20/08/2022.
//

enum BrowserLayout: String, CaseIterable {
    case grid
    case list

    var title: String {
        switch self {
        case .grid:
            return "Icons"
        case .list:
            return self.rawValue.capitalized
        }
    }

    var icon: SFSymbol {
        switch self {
        case .grid:
            return .grid
        case .list:
            return .list
        }
    }
}
