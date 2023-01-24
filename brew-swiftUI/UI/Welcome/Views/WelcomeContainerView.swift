//
//  WelcomeContainerView.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 02/11/2022.
//

import SwiftUI

struct WelcomeContainerView: View {
    // MARK: - Wrapped Properties
    @State private var currentPage: Int = 1

    @Binding var shouldShowWelcomeScreen: Bool

    // MARK: - Properties
    let welcomeItems: [WelcomeConfiguration]

    private var currentWelcomeItemsIndex: Int {
        currentPage - 1
    }

    private var welcomeItemsCount: Int {
        welcomeItems.count
    }

    // MARK: - Views
    var body: some View {
        WelcomeView(item: welcomeItems[currentWelcomeItemsIndex]) {
            handleItemTransition()
        }
        .background(Color.systemGroupedBackground)
    }
}

// MARK: - Private Methods
private extension WelcomeContainerView {
    func handleItemTransition() {
        withAnimation {
            if currentPage < welcomeItemsCount {
                currentPage += 1
            } else {
                print("👋 Welcome complete")
                shouldShowWelcomeScreen = false
            }
        }
    }
}

struct WelcomeContainerView_Previews: PreviewProvider {

    @State static var shouldDismiss: Bool = false

    static var previews: some View {
        WelcomeContainerView(
            shouldShowWelcomeScreen: $shouldDismiss,
            welcomeItems:  [
                WelcomeConfiguration.drinkTitle,
                WelcomeConfiguration.drinkKeyFeature
            ]
        )
    }
}
