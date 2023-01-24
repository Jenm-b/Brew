//
//  SocialSection.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 21/10/2022.
//

import SwiftUI

struct SocialSection: View {
    // MARK: - Wrapped Properties
    @Environment(\.openURL) private var openURL

    @State private(set) var errorAlertItem: AlertConfiguration?

    // MARK: - Properties
    let socialConfiguration: SocialConfiguration

    private var isErrorAlertPresented: Binding<Bool> {
        Binding<Bool>(
            get: {
                errorAlertItem != nil
            },
            set: { _ in
                errorAlertItem = .none
            }
        )
    }

    // MARK: - Views
    var body: some View {
        Section("Social") {
            ActionRow {
                SettingsRow(
                    title: "Feedback",
                    icon: .message,
                    iconTintColor: .mint
                )
            } action: {
                loadURL(withName: socialConfiguration.appStoreReviewURL)
            }
            ActionRow {
                SettingsRow(
                    title:  "App Store",
                    icon: .cart,
                    iconTintColor: .black
                )
            } action: {
                loadURL(withName: socialConfiguration.appStoreURL)
            }
            ActionRow {
                SettingsRow(
                    title: "Source Code",
                    icon: .hammer,
                    iconTintColor: .red
                )
            } action: {
                loadURL(withName: socialConfiguration.gitHubURL)
            }
        }.alert(isPresented: isErrorAlertPresented) {
            Alert(alertConfiguration: errorAlertItem ?? .item(forType: .generic))
        }
    }
}

// MARK: - Private Methods
private extension SocialSection {
    func loadURL(withName name: String) {
        if let URL = URL(string: name) {
            openURL(URL)
        } else  {
            print("Error \(URLError.badURL) ❌: Invalid URL")
        }
    }
}

struct SocialSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SocialSection(socialConfiguration:
                            SocialConfiguration(
                                gitHubURL: "My git hub is so boring probably not worth tapping",
                                appStoreURL: "App link to the best App in town...")
            )
        }
    }
}
