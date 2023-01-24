//
//  SocialConfiguration.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 28/10/2022.
//

struct SocialConfiguration {
    let gitHubURL: String
    let appStoreURL: String

    var appStoreReviewURL: String {
        return "\(appStoreURL)?action=write-review"
    }
}
