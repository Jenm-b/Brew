//
//  AboutSection.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 21/10/2022.
//

import SwiftUI

struct AboutSection: View {
    // MARK: - Properties
    let aboutConfiguration: AboutConfiguration

    // MARK: - Views
    var body: some View {
        Section("About") {
            SettingsRow(title: "App Name", icon: .pencil, iconTintColor: .brown) {
                Text(aboutConfiguration.appName)
            }
            SettingsRow(title: "App Version", icon: .swift, iconTintColor: .green) {
                Text("\(aboutConfiguration.appVersion)")
            }
            SettingsRow(title: "Minimum OS Version", icon: .shield , iconTintColor: .pink) {
                Text(aboutConfiguration.minimumOSVersion)
            }
            descriptionRow(withTitle: aboutConfiguration.developerInfoText)
        }
    }
}

// MARK: - Sub-Views
private extension AboutSection {
    func descriptionRow(withTitle title: String) -> some View {
        HStack {
            Spacer()
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

struct AboutSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AboutSection(aboutConfiguration: AboutConfiguration(
                developerInfoText: "Jen is an average developer"))
        }
    }
}
