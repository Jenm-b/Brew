//
//  AboutConfiguration.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 15/10/2022.
//

import Foundation

final class AboutConfiguration {
    // MARK: - Properties
    let developerInfoText: String

    lazy var appVersion: String = readFromInfoPlist(withKey: BundleKey.bundleShortVersionKey)
    lazy var appName: String = readFromInfoPlist(withKey: BundleKey.bundleDisplayNameKey)

    /// ``buildVersion`` not currently used
    lazy var buildVersion: String = readFromInfoPlist(withKey: BundleKey.bundleVersionKey)
    lazy var minimumOSVersion: String = readFromInfoPlist(withKey: BundleKey.minimumOSVersionKey)

    // MARK: - Init
    init(developerInfoText: String) {
        self.developerInfoText = developerInfoText
    }

    private func readFromInfoPlist(withKey key: String) -> String {
        return Bundle.main.infoDictionary?[key] as? String ?? BundleKey.notFound
    }
}

// MARK: - Constants
private extension AboutConfiguration {
    enum BundleKey {
        static let bundleDisplayNameKey = "CFBundleDisplayName"
        static let bundleShortVersionKey = "CFBundleShortVersionString"
        static let bundleVersionKey = "CFBundleVersion"
        static let minimumOSVersionKey = "MinimumOSVersion"

        static let notFound = "Unknown"
    }
}
