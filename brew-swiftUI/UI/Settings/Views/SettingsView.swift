//
//  SettingsView.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 19/09/2022.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    private let settingsConfiguration: SettingsConfiguration

    init(configuration: SettingsConfiguration = .drink) {
      settingsConfiguration = configuration
    }

    // MARK: - Views
    var body: some View {
        Form {
            StyleSection()
            HelpSection(helpSectionConfiguration: settingsConfiguration.helpConfiguration)
            SocialSection(socialConfiguration: settingsConfiguration.socialConfiguration)
            AboutSection(aboutConfiguration: settingsConfiguration.aboutConfiguration)
        }
        .clipped()
        .navigationTitle(settingsConfiguration.settingsTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
