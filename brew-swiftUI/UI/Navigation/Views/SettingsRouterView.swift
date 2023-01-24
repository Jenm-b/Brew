//
//  SettingsRouterView.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 19/09/2022.
//

import SwiftUI

struct SettingsRouterView: View {
    @StateObject private var router = Router<SettingsDestination>()

    // MARK: - Views
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            destinationView(for: .settings)
                .navigationDestination(
                    for: SettingsDestination.self,
                    destination: destinationView
                )
        }
        .environmentObject(router)
    }

    @ViewBuilder
    private func destinationView(for destination: SettingsDestination) -> some View {
        // More settings destinations might be added in the future 👀🤞
        switch destination {
        case .settings:
            SettingsView()
        }
    }
}
