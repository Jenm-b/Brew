//
//  CommonTitleSummary.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 06/11/2022.
//

import SwiftUI

struct CommonTitleSummary: View {
    // MARK: - Properties
    private let primaryText: String
    private let secondaryText: String
    private let isDivided: Bool

    // MARK: - Init
    init(primaryText: String,
         secondaryText: String,
         isDivided: Bool = false) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.isDivided = isDivided
    }

    // MARK: - Views
    var body: some View {
        VStack(spacing: Padding.item) {
            Text(primaryText)
                .titleStyle()
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .allowsTightening(true)
            if isDivided {
                Divider()
            }
            Text(secondaryText)
                .secondaryStyle()
        }
        .multilineTextAlignment(.center)
    }
}

struct CommonTitleSummary_Previews: PreviewProvider {
    static var previews: some View {
        CommonTitleSummary(
            primaryText: "Strictly Come Dancing 💃",
            secondaryText: "Watch Strictly Come Dancing every Saturday evening on BBC."
        )
        .padding(Padding.screen)
    }
}
