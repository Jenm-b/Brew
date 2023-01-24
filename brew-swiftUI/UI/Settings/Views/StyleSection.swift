//
//  StyleSection.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 21/10/2022.
//

import SwiftUI

struct StyleSection: View {
    // MARK: - Wrapper Properties
    @EnvironmentObject private var userPreferences: Preferences
    @ScaledMetric private var size: CGFloat = 1

    @State private var errorAlertItem: AlertConfiguration?

    // MARK: - Properties
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
        primaryContent
            .onChange(of: userPreferences.currentAppIconName) { appIconName in
                save(appIcon: appIconName)
            }
            .alert(isPresented: isErrorAlertPresented) {
                Alert(alertConfiguration: errorAlertItem ?? .item(forType: .generic))
            }
    }

    var primaryContent: some View {
        Section("Style") {
            SettingsRow(title: "", icon: .theme, iconTintColor: .purple) {
                Picker("Appearance", selection: $userPreferences.currentColorScheme) {
                    ForEach(userPreferences.availableThemes, id: \.self) { theme in
                        Label {
                            Text(theme.label)
                        } icon: {
                            RoundedRectangle(cornerRadius: Constants.iconCornerRadius)
                                .foregroundColor(theme.iconColor)
                                .clipRoundedRectangle(fill: Color.tertiaryLabel, padding: 1)
                                .frame(width: size * Constants.smallIconSize, height: size *  Constants.smallIconSize)
                        }
                    }
                    .labelStyle(.titleAndIcon)
                }
            }
            SettingsRow(title: "", icon: .pencil, iconTintColor: .teal) {
                Picker("App Icon", selection: $userPreferences.currentAppIconName) {
                    ForEach(userPreferences.availableIcons, id: \.self.iconName) { icon in
                        Label {
                            Text(icon.title)
                        } icon: {
                            Image(icon.previewIconName)
                                .styleImage(width: size * Constants.smallIconSize, height: size * Constants.smallIconSize)
                                .cornerRadius(Constants.iconCornerRadius)
                        }
                    }
                    .labelStyle(.titleAndIcon)
                }
            }
        }
        .pickerStyle(.navigationLink)
    }
}

private extension StyleSection {

    func save(appIcon: String) {
        Task { @MainActor in
            do {
                try await save(appIcon)
            } catch let error as AlternateIconError {
                errorAlertItem = AlertConfiguration(title: "App Icon Save Error", message: error.localizedDescription)
            }
        }
    }

    private func save(_ appIcon: String) async throws {
        guard UIApplication.shared.supportsAlternateIcons else {
            print(AppIconError.notSupported.localizedDescription)
            return
        }

        guard appIcon != UIApplication.shared.alternateIconName else {
            return
        }

        do {
            if appIcon == AppIconTheme.medium.iconName {
                try await UIApplication.shared.setAlternateIconName(nil)
            } else {
                try await UIApplication.shared.setAlternateIconName(appIcon)
            }
            print("App Icon updated to \(appIcon) app icon ✅ ")
        } catch {
            print("Error ❌: \(appIcon) app icon could not be saved. \(error.localizedDescription)")
            throw AppIconError.notSaved
        }
    }
}


struct StyleSection_Previews: PreviewProvider {
    @StateObject static private var userPreferences = Preferences()

    static var previews: some View {
        List {
            StyleSection()
                .environmentObject(userPreferences)
        }
    }
}
