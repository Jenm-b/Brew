//
//  CommonTextSummary.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 20/08/2022.
//

import SwiftUI

struct CommonTextSummary: View {
    // MARK: - Properties
    private let primaryText: String
    private let secondaryText: String
    private let primaryColor: Color
    private let secondaryColor: Color
    private let isDivided: Bool

    // MARK: - Init
    init(primaryText: String,
         secondaryText: String,
         primaryColor: Color = .label,
         secondaryColor: Color = .secondaryLabel,
         isDivided: Bool = false) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.isDivided = isDivided
    }

    // MARK: - Views
    var body: some View {
        VStack(alignment: .leading, spacing: Padding.textGap) {
            Text(primaryText)
                .primaryStyle(color: primaryColor)
            if isDivided {
                Divider()
            }
            Text(secondaryText)
                .secondaryStyle(color: secondaryColor)
                .multilineTextAlignment(.leading)
        }
    }
}

struct CommonTextSummary_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CommonTextSummary(
                primaryText: "This is a test",
                secondaryText: "This is a test for secondary title"
            )
            CommonTextSummary(
                primaryText: "This is a test",
                secondaryText: "This is a test for secondary title",
                isDivided: true
            )
        }
    }
}
