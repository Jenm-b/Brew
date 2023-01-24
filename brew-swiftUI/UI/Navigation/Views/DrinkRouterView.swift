//
//  DrinkRouterView.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 19/09/2022.
//

import SwiftUI

struct DrinkRouterView: View {
    @StateObject var router = Router<DrinkDestination>()
    @StateObject private var viewModel = DrinksListGalleryViewModel(drinkDataService: CoreDataDrinkService.shared)

    // MARK: - Views
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            destinationView(for: .drinkGallery)
                .navigationDestination(
                    for: DrinkDestination.self,
                    destination: destinationView
                )
        }
        .environmentObject(router)
        .onChange(of: router.navigationPath) { newValue in
            print("Navigation Path: \(router.navigationPath) 🚧 \n Navigation Count: \(router.navigationPath) 💐")
        }
    }

    @ViewBuilder
    private func destinationView(for destination: DrinkDestination) -> some View {
        switch destination {
        case .drinkGallery:
            DrinkGalleryView(viewModel: viewModel)
        case .drinkDetail(let drink):
            DrinkFormView(dataService: CoreDataDrinkService.shared, drink: drink ?? .defaultDrink())
        }
    }
}
