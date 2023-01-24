//
//  DrinkGridItem.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 26/09/2022.
//

import SwiftUI

struct DrinkGridItem: View {
    // MARK: - Wrapper Properties
    @Environment(\.editMode) private var editMode

    @Binding private(set) var selectedDrinkIDs: Set<Drink>
    @State private(set) var isShaking: Bool = false

    // MARK: - Properties
    let viewModel: DrinkItemViewModel
    let onTap: (() -> ())

    private var isEditing : Bool {
        editMode?.wrappedValue.isEditing == true
    }

    private var isItemSelected: Binding<Bool> {
        Binding {
            selectedDrinkIDs.contains(viewModel.drink)
        } set: { _ in
            handleSelection()
        }
    }

    // MARK: - Views
    var body: some View {
        gridItem
            .buttonStyle(.plain)
            .contextMenu {
                !isEditing ? DrinkShareButton(drink: viewModel.drink) : nil
            }
            .overlay(
                RoundedRectangle(cornerRadius:  Constants.buttonRadius)
                    .stroke(
                        Color.primaryTheme.gradient,
                        lineWidth: isEditing ? 2 : 0
                    )
            )
            .overlay(alignment: .topTrailing) {
                CheckmarkButton(isChecked: isItemSelected)
                    /// Prevents checkmark button redrawing in ``EditMode``
                    .animation(nil, value: isShaking)
                    .opacity(isEditing ? 1 : 0)
                    .offset(x: 4, y: -8)
            }
            .shaking(isShaking: isShaking)
            .onAppear {
                isShaking = isEditing
            }
            .onTapGesture {
                if isEditing {
                    handleSelection()
                } else {
                    onTap()
                }
            }
            .onChange(of: isEditing) { [isEditing] newIsEditing in
                // Additional logic here because I think isEditing gets called a lot of times so causing view
                // to redraw unnecessarily
                // need to properly investigate this
                if newIsEditing != isEditing {
                    isShaking = newIsEditing
                }
                if newIsEditing == false {
                    // Nuke all selections when user exists edit mode
                    selectedDrinkIDs.removeAll()
                }
            }
    }

    var gridItem: some View {
        VStack(spacing: Padding.item) {
            DrinkStrengthGauge(
                strength: viewModel.strength,
                brewerName: viewModel.drink.user
            )
            Text(viewModel.title)
                .primaryStyle()
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.01)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipRoundedRectangle(
            Constants.buttonRadius,
            fill: Color.secondarySystemGroupedBackground,
            padding: Padding.item
        )
    }
}

// MARK: - Private Methods
private extension DrinkGridItem {
    func handleSelection() {
        if selectedDrinkIDs.contains(viewModel.drink) {
            selectedDrinkIDs.remove(viewModel.drink)
        } else {
            selectedDrinkIDs.insert(viewModel.drink)
        }
    }
}

struct DrinkGridItem_Previews: PreviewProvider {

    @State static var selections: Set<Drink> = Set(arrayLiteral: Drink.mockDrink, Drink.mockDrink)
    @State static var mode: EditMode = .active

    static var previews: some View {
        LazyVStack(spacing: 10) {
            DrinkGridItem(
                selectedDrinkIDs: $selections,
                viewModel: DrinkItemViewModel(drink: .mockDrink),
                onTap: {
                    print("Tapped!")
                }
            )
            DrinkGridItem(
                selectedDrinkIDs: $selections,
                viewModel: DrinkItemViewModel(drink: .mockDrink),
                onTap: {  }
            )
            DrinkGridItem(
                selectedDrinkIDs: $selections,
                viewModel: DrinkItemViewModel(drink: .mockDrink),
                onTap: {  }
            )
        }
        .background(Color.systemGroupedBackground)
        .environment(\.editMode, $mode)
    }
}
