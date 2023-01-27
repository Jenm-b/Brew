//
//  DrinkFormView.swift
//  SwiftUINotes
//
//  Created by Jennifer Munro-Brown on 18/06/2022.
//

import SwiftUI

struct DrinkFormView: View {
    enum FocusedField {
        case brewerName, notes
    }

    // MARK: - Wrapper Properties
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var route: Router<DrinkDestination>
    @StateObject private var viewModel: DrinkFormViewModel

    @ScaledMetric private var size: CGFloat = 1

    @State private(set) var errorAlertItem: AlertConfiguration? = nil

    @FocusState private var focusedField: FocusedField?

    // MARK: - Properties
    private var iconBackgroundColor: Color {
        viewModel.localDrink.strength.color
    }

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

    init(dataService: DrinkService, drink: Drink) {
        _viewModel = StateObject(wrappedValue: DrinkFormViewModel(dataService: dataService, drink: drink))
    }

    // MARK: - Views
    var body: some View {
        drinksDetailForm
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    saveButton
                        .labelStyle(.titleOnly)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Button {
                        focusedField = nil
                    } label: {
                        Image(symbol: .keyboardDown)
                    }
                }
            }
            .alert(isPresented: isErrorAlertPresented) {
                Alert(alertConfiguration: errorAlertItem ?? .item(forType: .generic))
            }
    }
}

// MARK: - Form Views
private extension DrinkFormView {
    var drinksDetailForm: some View {
        Form {
            header
            personalSection
            detailSection
            notesSection
            Section {
                saveButton
                shareButton
                deleteButton
            }
            .labelStyle(.titleAndIcon)
        }
    }

    var header: some View {
        Label {
            CommonTitleSummary(
                primaryText: viewModel.title,
                secondaryText: viewModel.timeElapsedTitle
            )
        } icon: {
            Image(symbol: .tearDrop)
                .clipImage(
                    fill: viewModel.localDrink.strength.color,
                    width: size * Constants.largeIconSize,
                    height: size * Constants.largeIconSize,
                    foregroundStyle: Color.primaryTheme
                )
        }
        .labelStyle(.vertical(spacing: Padding.item))
        .listRowBackground(Color.systemGroupedBackground)
        .frame(maxWidth: .infinity)
    }

    var personalSection: some View {
        Section {
            TextField(
                "",
                text: $viewModel.usernameInput,
                prompt: Text("Jane Doe")
            )
            .textContentType(.nickname)
            .focused($focusedField, equals: .brewerName)
            .lineLimit(1)
            .textInputAutocapitalization(.words)
            if !viewModel.usernameValidationErrorMessages.isEmpty {
                container(withValidationErrors: viewModel.usernameValidationErrorMessages)
            }
        } header: {
            Text("Personal Details")
        } footer: {
            Text("A name for you to identify this drinker. This can be different to the full birth name.")
        }
    }

    var detailSection: some View {
        Section("Brew Details") {
            Picker("Brew", selection: $viewModel.localDrink.name) {
                ForEach(Brew.allCases.sorted(), id: \.self) {
                    Text($0.rawValue)
                }
            }
            strengthRow
            Picker("Milk", selection: $viewModel.localDrink.milk) {
                ForEach(Milk.allCases.sorted(), id: \.self) {
                    Text($0.rawValue)
                }
            }
            Picker("Sugar", selection: $viewModel.localDrink.sweetener) {
                ForEach(Sweetener.allCases.sorted(), id: \.self) {
                    Text($0.rawValue)
                }
            }
            if viewModel.localDrink.sweetener != .none {
                Stepper(
                    "\(viewModel.localDrink.teaSpoonsSugar) tsp(s) of Sugar",
                    value: $viewModel.localDrink.teaSpoonsSugar,
                    in: 1...10
                )
            }
            Toggle("Caffeinated", isOn: $viewModel.localDrink.caffeinated)
                .tint(.primaryTheme)
        }
    }

     var notesSection: some View {
        Section {
            TextField("", text: $viewModel.notesInput, axis: .vertical)
                .focused($focusedField, equals: .notes)
                .lineLimit(1...2)
            if !viewModel.notesValidationErrorMessages.isEmpty {
                container(withValidationErrors: viewModel.notesValidationErrorMessages)
            }
        } header: {
            Text("Notes")
        } footer: {
            Text("Note down any weird and wonderful preferences to guarantee this drinker receives the best possible brew. For example, morning coffee must be served in a pink mug.")
        }
    }

    func container(withValidationErrors errors: Set<Validation>) -> some View {
        ForEach(Array(errors), id: \.self) {
            CommonErrorSummary(error: $0)
                .transition(.move(edge: .bottom))
        }
    }

    var strengthRow: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Strength")
                Spacer()
                Text("\(viewModel.localDrink.strength.title)")
                    .foregroundColor(.secondaryLabel)
                    .animation(.default, value: viewModel.sliderStrengthValue)
            }
            HStack {
                image(forStrength: Strength.extraWeak)
                Slider(value: $viewModel.sliderStrengthValue, in: 0...Double(Strength.black.value))
                    .tint(viewModel.localDrink.strength.color.gradient)
                image(forStrength: Strength.black)
            }
            .clipRoundedRectangle(Constants.buttonRadius ,fill: .ultraThinMaterial, padding: Padding.textGap)
        }
    }

    func image(forStrength strength: Strength) -> some View {
        Image(systemName: "\(strength.value)")
            .symbolVariant(.circle)
            .symbolVariant(.fill)
            .symbolRenderingMode(.palette)
            .foregroundStyle(Color(strength.textcolor), strength.color)
    }
}

// MARK: - Button Views
private extension DrinkFormView {

    var saveButton: some View {
        Button {
            save()
        } label: {
            Label("Save", systemImage: SFSymbol.save.title)
                .imageScale(.medium)
                .symbolRenderingMode(.hierarchical)
                .tint(Color.primaryTheme)
        }
        .disabled(viewModel.shouldDisableSaveButton)
    }

    var shareButton: some View {
        DrinkShareButton(drink: viewModel.localDrink)
            .disabled(viewModel.shouldDisableDeleteAndShareButton)
    }

    var deleteButton: some View {
        Button(role: .destructive) {
            didRequestDelete()
        } label: {
            Label("Delete", systemImage: SFSymbol.trash.title)
                .imageScale(.medium)
                .symbolRenderingMode(.hierarchical)
        }
        .disabled(viewModel.shouldDisableDeleteAndShareButton)
    }
}

// MARK: - Private Methods
private extension DrinkFormView {
    func save() {
        Task {
            do {
                try await viewModel.saveAsync()
                route.pop()
            } catch let error {
                errorAlertItem = AlertConfiguration.item(forType: .serviceError(error))
            }
        }
    }

    func delete() {
        Task {
            do {
                try await viewModel.deleteAsync()
                route.pop()
            } catch let error {
                errorAlertItem = AlertConfiguration.item(forType: .serviceError(error))
            }
        }
    }

    func didRequestDelete() {
        let deleteAlertItem = AlertConfiguration.item(forType: .deleteWarning([viewModel.localDrink]), action: {
            delete()
        })

        errorAlertItem = deleteAlertItem
    }
}


struct DrinkFormView_Previews: PreviewProvider {
    @StateObject static var route = Router<DrinkDestination>()
    @StateObject static private var userPreferences = Preferences()

    static var previews: some View {
        NavigationView {
            DrinkFormView(
                dataService: CoreDataDrinkService(),
                drink: Drink.mockDrink
            )
                .environmentObject(route)
                .environmentObject(userPreferences)
                .environment(\.sizeCategory, ContentSizeCategory.small)
        }
    }
}
