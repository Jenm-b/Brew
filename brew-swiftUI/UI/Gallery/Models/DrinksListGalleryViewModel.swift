//
//  DrinksListGalleryViewModel.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 06/07/2022.
//

import Combine
import SwiftUI

enum ViewState {
    case idle
    case empty
    case loaded
}

class DrinksListGalleryViewModel: ObservableObject {
    // MARK: - Wrapper Properties
    @Published var drinks: [Drink] = []
    @Published var selectedDrinks: Set<Drink> = []

    @Published var sort = DrinkSortOrder.name
    @Published var layout = BrowserLayout.list

    @Published var viewState: ViewState = .idle

    // MARK: - Properties
    private let drinkDataService: DrinkService

    private(set) var cancellables: Set<AnyCancellable> = .init()

    var allDrinksSelected: Bool {
        return selectedDrinks.count == drinks.count
    }

    var noDrinksSelected: Bool {
        return selectedDrinks.isEmpty
    }

    var editModeNavigationTitle: String {
        if selectedDrinks.isEmpty {
            return Constants.defaultTitle
        } else {
            let drinkDescription = selectedDrinks.count == 1 ? Constants.singleDrink : Constants.multipleDrinks
            return "\(selectedDrinks.count.description) \(drinkDescription)"
        }
    }

    // MARK: - Init
    init(drinkDataService: DrinkService) {
        self.drinkDataService = drinkDataService
        subscribe()
        fetchDrinks()
    }

    // MARK: - Public Methods
    func delete() async throws {
        try await self.drinkDataService.delete(objects: Array(selectedDrinks))
        await MainActor.run {
            selectedDrinks.removeAll()
        }
    }

    func handleSelectAll() {
        if !allDrinksSelected {
            // Creates a set that holds the drinks that are unique to ``drinks``
            let unSelectedDrinks = Set(drinks).symmetricDifference(selectedDrinks)
            unSelectedDrinks.forEach {
                selectedDrinks.insert($0)
            }
        } else {
            selectedDrinks.removeAll()
        }
    }
}

// MARK: - Private Methods
private extension DrinksListGalleryViewModel {
    func fetchDrinks() {
        drinkDataService.fetch()
    }

    func subscribe() {
        drinkDataService.drinksPublisher
            .combineLatest($sort)
            .receive(on: DispatchQueue.main)
            .map {
                return self.drinks($0, sortedBy: $1)
            }
            .assign(to: &$drinks)

        $drinks
            .receive(on: DispatchQueue.main)
            .map { $0.isEmpty }
            .removeDuplicates() // Removes repeating empty states from the upstream publisher
            .sink { [weak self] isEmpty in
                guard let self = self else { return }

                if isEmpty && self.viewState != .empty {
                    self.viewState = .empty
                } else if self.viewState != .loaded && !isEmpty {
                    self.viewState = .loaded
                }
        }.store(in: &cancellables)
    }

    private func drinks(_ drinks: [Drink], sortedBy sort: DrinkSortOrder) -> [Drink] {
        switch sort {
        case .name:
            return drinks.sorted { $0.user.localizedCompare($1.user) == .orderedAscending }
        case .drink:
            return drinks.sorted { $0.name.rawValue.localizedCompare($1.name.rawValue) == .orderedAscending }
        }
    }
}

//MARK: - Constants
extension DrinksListGalleryViewModel {
    enum Constants {
        static let defaultTitle: String = "My \(Constants.multipleDrinks)"
        static let singleDrink: String = "Drink"
        static let multipleDrinks: String = singleDrink + "s"
    }
}
