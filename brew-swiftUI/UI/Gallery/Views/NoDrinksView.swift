//
//  NoDrinksView.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 16/12/2022.
//

import SwiftUI

struct NoDrinksView: View {

    var body: some View {
        Label {
            CommonTitleSummary(
                primaryText: "No Drinks",
                secondaryText: "To add a drink, tap the plus icon on the top right!\nLets get brewing!"
            )
        } icon: {
            Image(symbol: .warningBubble)
                .styleImage(
                    width: Constants.mediumIconSize,
                    height: Constants.mediumIconSize,
                    foregroundStyle: Color.primaryTheme.gradient
                )
        }
        .labelStyle(.vertical(spacing: Padding.item))
        .padding(Padding.screen)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        NoDrinksView()
    }
}
