//
//  DrinkFormViewModel.swift
//  SwiftUINotes
//
//  Created by Jennifer Munro-Brown on 18/06/2022.
//

import Combine
import SwiftUI

final class DrinkFormViewModel: ObservableObject {
    // MARK: - Wrapper Properties
    @Published var localDrink: Drink

    @Published private(set) var usernameValidationErrorMessages: Set<Validation> = []
    @Published private(set) var notesValidationErrorMessages: Set<Validation> = []

    @Published private(set) var shouldShowUsernameErrorContainer: Bool = false
    @Published private(set) var shouldShowNotesErrorContainer: Bool = false

    @Published var sliderStrengthValue: Double

    @Published var usernameInput: String {
        didSet {
            // Logic in didSet to prevent recursive loop
            if usernameInput.count > Constants.minimumUsernameCharacterCount && oldValue.count <= Constants.minimumUsernameCharacterCount {
                usernameInput = oldValue
            }
        }
    }

    @Published var notesInput: String
    {
        didSet {
            // Logic in didSet to prevent recursive loop
            if notesInput.count > Constants.minimumNotesCharacterCount && oldValue.count <= Constants.minimumNotesCharacterCount {
                notesInput = oldValue
            }
        }
    }

    // MARK: - Properties
    private(set) var cancellables: Set<AnyCancellable> = .init()

    private let drinkDataService: DrinkService
    private let previousDrink: Drink
    private let isNewDrink: Bool

    var shouldDisableDeleteAndShareButton: Bool {
        formHasValidationErrors || isNewDrink
    }

    var shouldDisableSaveButton: Bool {
        formHasValidationErrors || !drinkHasChanges
    }

    private var formHasValidationErrors: Bool {
        !usernameValidationErrorMessages.isEmpty || !notesValidationErrorMessages.isEmpty
    }

    private var drinkHasChanges: Bool {
        localDrink != previousDrink
    }

    var title: String {
        let newDrinkTitle = "Add Drink"
        let brewersDrinkTitle =  "\(localDrink.user.trimmingCharacters(in: .whitespaces))'s \(localDrink.name.rawValue.capitalized)"
        return isNewDrink ? newDrinkTitle : brewersDrinkTitle
    }

    var timeElapsedTitle: String {
        let timeElapsedString = Date.timeElapsedString(since: localDrink.dateCreated)
        print("\(timeElapsedString)")
        return "Last modified \(timeElapsedString)"
    }

    // MARK: - Init
    init(dataService: DrinkService, drink: Drink) {
        self.drinkDataService = dataService

        self.localDrink = drink
        self.previousDrink = drink

        self.isNewDrink = drink.user.isEmpty

        self.usernameInput = drink.user
        self.notesInput = drink.notes

        self.sliderStrengthValue = Double(drink.strength.value)

        subscribe()
    }

    // MARK: - Public Methods
    func saveAsync() async throws {
        try await drinkDataService.save(object: localDrink)
    }

    func deleteAsync() async throws {
        try await self.drinkDataService.delete(object: self.localDrink)
    }
}

// MARK: - Private Methods
private extension DrinkFormViewModel {
    func subscribe() {

        $sliderStrengthValue
            .receive(on: DispatchQueue.main)
            .compactMap {
                Strength(value: Int($0))
            }
            .sink { [weak self] strength in
                guard let self = self else { return }
                self.localDrink.strength = strength
            }.store(in: &cancellables)

        $usernameInput
            .required()
            .merge(with: $usernameInput.maxCharacters(Constants.minimumUsernameCharacterCount))
            .receive(on: DispatchQueue.main)
            .print("Username validation logs", to: nil)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.handle(
                    validationResult: result,
                    errorMessages: &self.usernameValidationErrorMessages,
                    input: self.usernameInput,
                    update: &self.localDrink.user)
            }.store(in: &cancellables)

        $notesInput
            .maxCharacters(Constants.minimumNotesCharacterCount)
            .print("Notes validation logs", to: nil)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.handle(
                    validationResult: result,
                    errorMessages: &self.notesValidationErrorMessages,
                    input: self.notesInput,
                    update: &self.localDrink.notes)

            }.store(in: &cancellables)
    }

    func handle(validationResult result: ValidationResult,
                        errorMessages: inout Set<Validation>,
                        input: String,
                        update: inout String) {
        switch result {
        case .invalid(let validation):
            /// ``errorMessages`` is a ``Set``so will insert only if the error does not appear in the list
            /// do not need if statement here but might help preventing redraw?
            if !errorMessages.contains(validation) {
                errorMessages.insert(validation)
            }
        case .valid(let validation):
            /// ``errorMessages`` is a ``Set``so will remove if the error appears in the list
            /// do not need if statement here but might help preventing redraw?
            if errorMessages.contains(validation) {
                errorMessages.remove(validation)
            }
            update = input
        }
    }
}

private extension DrinkFormViewModel {
    enum Constants {
        static let minimumUsernameCharacterCount: Int = 15
        static let minimumNotesCharacterCount: Int = 30
    }
}
