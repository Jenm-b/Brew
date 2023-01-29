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
    @Published var sort = DrinkSortOrder.name
    @Published var test: [String] = []

    @Published var layout = BrowserLayout.list

    @Published var selectedDrinks: Set<Drink> = []
    @Published private(set) var drinks: [Drink] = []

    @Published private(set) var viewState: ViewState = .idle

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
            return TitleConstants.defaultTitle
        } else {
            let drinkDescription = selectedDrinks.count == 1 ? TitleConstants.singleDrink : TitleConstants.multipleDrinks
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
            // Publishes a tuple upon receiving output from upstream `drinksPublisher` and `sort` publisher
            .combineLatest($sort)
            .receive(on: DispatchQueue.main)
            .map {
                return self.drinks($0, sortedBy: $1)
            }
            .assign(to: &$drinks)

        $drinks
            // Ignores the first value received from drinks` publisher e.g. drops the value used to initialise drinks publisher
            .dropFirst()
            .map { $0.isEmpty }
            // Removes repeating `isEmpty` states from the upstream `drinks` publisher
            .removeDuplicates()
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
    enum TitleConstants {
        static let defaultTitle: String = "My \(TitleConstants.multipleDrinks)"
        static let singleDrink: String = "Drink"
        static let multipleDrinks: String = singleDrink + "s"
    }
}
