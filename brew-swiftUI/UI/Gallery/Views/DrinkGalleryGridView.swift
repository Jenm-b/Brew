//
//  DrinkGalleryGridView.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 06/07/2022.
//

import SwiftUI

struct DrinkGalleryGridView: View {
    // MARK: - Wrapper Properties
    @Environment(\.editMode) private var editMode

    @Binding private(set) var selectedDrinkIDs: Set<Drink>

    // MARK: - Properties
    let drinks: [Drink]
    let onTap: (Drink) -> ()

    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120, maximum: 250)),
    ]

    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing == true
    }

    // MARK: - Views
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: Padding.stackGap) {
                    ForEach(drinks) { drink in
                        DrinkGridItem(
                            selectedDrinkIDs: $selectedDrinkIDs,
                            viewModel: DrinkItemViewModel(drink: drink)) {
                                if !isEditing {
                                    onTap(drink)
                                }
                            }
                    }
                }
                .padding(Padding.screen)
                .animation(.spring(), value: drinks)
        }
    }
}

struct DrinkGalleryGrid_Previews: PreviewProvider {

    @State static var drinks = [
        Drink.defaultDrink(),
        Drink.defaultDrink()
    ]

    @State static var selections = Set<Drink>()

    static var previews: some View {
        ScrollView {
            DrinkGalleryGridView(
                selectedDrinkIDs: $selections,
                drinks: drinks,
                onTap: { _ in
                    print("Selected grid")
                }
            )
            .background(Color.red)
        }
    }
}
