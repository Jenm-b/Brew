//
//  SettingConfiguration.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 15/10/2022.
//

import Foundation

struct SettingsConfiguration {
    let settingsTitle: String
    let helpConfiguration: HelpConfiguration
    let aboutConfiguration: AboutConfiguration
    let socialConfiguration: SocialConfiguration
}


extension SettingsConfiguration {

    static let drink: SettingsConfiguration = SettingsConfiguration(
        settingsTitle: "Settings",
        helpConfiguration: HelpConfiguration(
            faqs: [
                FrequentlyAskedQuestion(
                    question: "How can I edit a drink details?",
                    answer: "When viewing all your drinks, tap the drink you would like to edit. You now will be able to edit the drink's type, milk, sweetener etc. When you are happy with the modifications tap the save button at the bottom of the screen."
                ),
                FrequentlyAskedQuestion(
                    question: "If I delete a drink on the app, will it be gone forever?",
                    answer: "Yes. At this time, there isn't a tool to restore a deleted drink."
                ),
                FrequentlyAskedQuestion(
                    question: "How do I give feedback?",
                    answer: "We would love to hear from you. Please get in touch through the app by tapping the feedback button on the Settings page or directly through the App Store."
                ),
                FrequentlyAskedQuestion(
                    question: "How do I share a drink?",
                    answer: "Option 1. When viewing all your drinks, long press the drink you would like to share. \nOption 2. When viewing a drink, tap the share button at the bottom of the form."
                ),
                FrequentlyAskedQuestion(
                    question: "Is this app free?",
                    answer: "Yes. This app is free for everyone to use."
                )
            ]
        ),
        aboutConfiguration: AboutConfiguration(
            developerInfoText: "Designed and Developed by Jennifer Munro-Brown"
        ),
        socialConfiguration: SocialConfiguration(
            gitHubURL: "https://github.com/Jenm-b/brew-swiftUI",
            appStoreURL: "https://apps.apple.com/app/1660328280"
        )
    )
}
