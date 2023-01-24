//
//  DrinkRowItem.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 30/11/2022.
//

import SwiftUI
import WrappingStack

struct DrinkRowItem: View {
    // MARK: - Properties
    let viewModel: DrinkItemViewModel
    let onTap: () -> Void

    // MARK: - Views
    var body: some View {
        ActionRow {
            drinkSummaryLabel
        } action: {
            onTap()
        }
        .padding([.top, .bottom], Padding.textGap)
        .listRowBackground(Color.secondarySystemGroupedBackground)
    }

    private var drinkSummaryLabel: some View {
        Label {
            VStack(alignment: .leading, spacing: Padding.textGap) {
                Text(viewModel.title)
                    .primaryStyle()
                drinkDetailTags
            }
        } icon: {
            DrinkStrengthGauge(strength: viewModel.strength, brewerName: viewModel.drink.user)
        }
        .labelStyle(.centeredImage())
    }

    private var drinkDetailTags: some View {
        WrappingHStack(
            itemSpacing: 2,
            lineSpacing: Padding.textGap,
            arrangement: .nextFit,
            edgeAlignment: .leading) {
                ForEach(viewModel.keyDetails, id: \.self) {
                    tagView(title: $0)
                }
            }
    }

    private func tagView(title: String) -> some View {
        Text(title)
            .font(.system(.caption2, design: .rounded))
            .foregroundColor(.primaryTheme)
            .padding(Padding.textGap)
            .background(
                Capsule()
                    .foregroundColor(.primaryTheme.opacity(0.1))
            )
    }
}

struct DrinkRowItem_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DrinkRowItem(viewModel: DrinkItemViewModel(drink: .mockDrink), onTap: {
                print("Lights camera DRINKKKKKK 📸")
            })
            DrinkRowItem(viewModel: DrinkItemViewModel(drink: .defaultDrink()), onTap: {})
        }
        .listStyle(.insetGrouped)
    }
}
