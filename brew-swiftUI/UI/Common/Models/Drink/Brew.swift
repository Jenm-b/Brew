//
//  Brew.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 17/11/2022.
//

enum Brew: String, CaseIterable, Hashable {
    case coffee
    case mocha
    case hotChocolate = "hot chocolate"
    case tea
    case greenTea = "green tea"
    case peppermint
    case earlGray = "earl gray"
    case chai
    case matcha
    case chamomile
    case fruit
    case jasmine
    case other
}

extension Brew: Comparable {
    static func < (lhs: Brew, rhs: Brew) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
