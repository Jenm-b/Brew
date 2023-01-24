//
//  Milk.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 17/11/2022.
//

enum Milk: String, CaseIterable {
    case oat
    case soya
    case almond
    case coconut
    case skimmed
    case semiSkimmed = "semi-skimmed"
    case fullFat = "full-fat"
    case cream
    case other
    case none = "no milk"
}

extension Milk: Comparable {
    static func < (lhs: Milk, rhs: Milk) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
