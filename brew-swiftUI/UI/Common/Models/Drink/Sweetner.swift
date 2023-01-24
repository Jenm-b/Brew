//
//  Sweetner.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 17/11/2022.
//

enum Sweetener: String, CaseIterable {
    case honey
    case sugar
    case sweetener
    case demeraraSugar = "demerara sugar"
    case other
    case none = "no sweetener"
}

extension Sweetener: Comparable {
    static func < (lhs: Sweetener, rhs: Sweetener) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
