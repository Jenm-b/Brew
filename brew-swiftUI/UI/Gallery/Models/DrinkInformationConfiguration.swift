//
//  DrinkInformationConfiguration.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 11/12/2022.
//

struct DrinkInformationConfiguration: Hashable {
    let primary: String
    let topic: String

    let imageName: String
    let summaryPoints: [Summary]
}

extension DrinkInformationConfiguration {
    static let tea: DrinkInformationConfiguration  = DrinkInformationConfiguration(
        primary: "How to Brew the Perfect Cup of Tea?",
        topic: "Brew Guide",
        imageName: "tea", summaryPoints: [
        Summary(
            primary: "Boil Water",
            secondary: "Fill kettle with suitable amount of water and turn it on."),
        Summary(
            primary: "Add Tea and Hot Water",
            secondary: "Add a tea bag into your mug and pour over the hot water...stir briefly."),
        Summary(
            primary: "Let it Brew",
            secondary: "Let it sit for about 4-5 minutes."),
        Summary(
            primary: "Give it a Squeeze",
            secondary: "Gently squeeze the tea bag against the side of the mug and remove."),
        Summary(
            primary: "Customise",
            secondary: "Add milk, sugar, honey, lemon or nothing at all. Enjoy!")
    ])

    static let cafetiereCoffee: DrinkInformationConfiguration  = DrinkInformationConfiguration(
        primary: "How to Make Cafetiere Coffee?",
        topic: "Brew Guide",
        imageName: "beansInHands",
        summaryPoints: [
        Summary(
            primary: "Pre-warm the Cafetiere",
            secondary: "Warming the cafetiere before starting will help you keep the brewed coffee warmer for longer."),
        Summary(
            primary: "Weigh out the Coffee Grounds",
            secondary: "Measure the ground coffee depending on how many people are having the coffee."),
        Summary(
            primary: "Add Warm Water",
            secondary: "Pour warm water from the kettle."),
        Summary(
            primary: "Let it Brew",
            secondary: "Let it sit for about 3-4 minutes before you plunge the cafetiere."),
        Summary(
            primary: "Give it a Stir",
            secondary: "Use a wooden spoon to stir the coffee grounds in the water - this helps the coffee infuse..."),
        Summary(
            primary: "Pour",
            secondary: "Grab a mug and carefully pour the coffee into a mug. Enjoy!")
    ])

    static let instantCoffee: DrinkInformationConfiguration  = DrinkInformationConfiguration(
        primary: "How to Make Instant Coffee?",
        topic: "Brew Guide",
        imageName: "coffees",
        summaryPoints: [
        Summary(
            primary: "Boil Water",
            secondary: "Fill kettle with suitable amount of water and turn it on."),
        Summary(
            primary: "Add Coffee and Water",
            secondary: "Add 1–2 teaspoons (2–4g) of instant coffee to the mug. Pour hot water over the top."),
        Summary(
            primary: "Stir",
            secondary: "Grab a spoon and give it a good stir."),
        Summary(
            primary: "Customise",
            secondary: "Add milk, sugar, honey or nothing at all. Enjoy!")
    ])
}
