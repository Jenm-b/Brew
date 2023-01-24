//
//  BrewSwiftUIApp.swift
//  SwiftUINotes
//
//  Created by Jennifer Munro-Brown on 10/06/2022.
//

import SwiftUI

@main
struct BrewSwiftUIApp: App {
    // MARK: - Wrapper Properties
    @StateObject var userPreferences: Preferences = Preferences()
    @State private var selectedTabItem: TabBarItem = .drinks

    // MARK: - Properties
    private let tabItems = TabBarItem.allCases

    // MARK: - Views
    var body: some Scene {
        WindowGroup {
            tabView
                .sheet(isPresented: $userPreferences.showWelcomeScreen) {
                    welcomeView
                }
        }
    }

    var tabView: some View {
        TabView(selection: $selectedTabItem.animation()) {
            ForEach(tabItems, id: \.self) { tabItem in
                tabItem.routerView
                    .tabItem {
                        Label(tabItem.title, systemImage: tabItem.icon.title)
                    }
            }
        }
        .accentColor(Color.primaryTheme)
        .preferredColorScheme(userPreferences.currentColorScheme.toColorScheme)
        .environmentObject(userPreferences)
    }

    var welcomeView: some View {
        WelcomeContainerView(
            shouldShowWelcomeScreen:  $userPreferences.showWelcomeScreen,
            welcomeItems: [
                WelcomeConfiguration.drinkTitle,
                WelcomeConfiguration.drinkKeyFeature
            ]
        )
        .presentationDetents([.large])
        .interactiveDismissDisabled(userPreferences.showWelcomeScreen)
        .preferredColorScheme(userPreferences.currentColorScheme.toColorScheme)
    }
}
