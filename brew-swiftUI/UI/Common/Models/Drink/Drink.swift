//
//  Drink.swift
//  SwiftUINotes
//
//  Created by Jennifer Munro-Brown on 18/06/2022.
//

import Foundation

struct Drink: Identifiable, Equatable, Hashable {
    var id: UUID
    var name: Brew
    var user: String
    var milk: Milk
    var sweetener: Sweetener
    var teaSpoonsSugar: Int
    var caffeinated: Bool
    var strength: Strength
    var notes: String
    var dateCreated: Date

    init(CDDrink: CoreDataDrink) {
        self.id = CDDrink.id
        self.name = .init(rawValue: CDDrink.name) ?? .other
        self.user = CDDrink.user
        self.milk = .init(rawValue: CDDrink.milk) ?? .none
        self.sweetener = .init(rawValue: CDDrink.sweetener) ?? .none
        self.caffeinated = CDDrink.caffeinated
        self.strength = Strength(rawValue: CDDrink.strength) ?? .medium
        self.notes = CDDrink.notes ?? ""
        self.teaSpoonsSugar = Int(CDDrink.teaSpoonsOfSugar)
        self.dateCreated = CDDrink.date ?? .now
    }

    init(id: UUID, name: Brew, user: String, milk: Milk, sweetener: Sweetener, caffeinated: Bool, strength: Strength, notes: String, teaSpoonsSugar: Int, date: Date = .now) {
        self.id = id
        self.name = name
        self.user = user
        self.milk = milk
        self.sweetener = sweetener
        self.caffeinated = caffeinated
        self.strength = strength
        self.notes = notes
        self.teaSpoonsSugar = teaSpoonsSugar
        self.dateCreated = date
    }
}

extension Drink {

    static func defaultDrink() -> Drink {
        Drink(
            id: .init(),
            name: .coffee,
            user: "",
            milk: .none,
            sweetener: .none,
            caffeinated: true,
            strength: .medium,
            notes: "",
            teaSpoonsSugar: 1)
    }

    static let mockDrink: Drink =
        Drink(
            id: UUID(),
            name: .matcha,
            user: "Jen",
            milk: .oat,
            sweetener: .honey,
            caffeinated: true,
            strength: .strong,
            notes: "Pink Mug Please",
            teaSpoonsSugar: 2
        )
}
