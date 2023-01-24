//
//  ActionRow.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 17/11/2022.
//

import SwiftUI

struct ActionRow<PrimaryContent: View>: View {
    // MARK: - Properties
    private let imageTintColor: Color
    private let systemImageName: String

    private let primaryContent: PrimaryContent
    private var onTap: () -> ()

    // MARK: - Init
    init(
        systemImageName: String = SFSymbol.chevronForward.rawValue,
        imageTintColor: Color = .secondaryLabel,
        @ViewBuilder primaryContent: () -> PrimaryContent,
        action: @escaping () -> ()
    ) {
        self.systemImageName = systemImageName
        self.primaryContent = primaryContent()
        self.imageTintColor = imageTintColor
        self.onTap = action
    }

    // MARK: - Views
    var body: some View {
        HStack {
            primaryContent
            Spacer()
            Image(systemName: systemImageName)
                .imageScale(.small)
                .font(.headline)
                .foregroundColor(imageTintColor)
        }
        .onTapGesture {
            onTap()
        }
    }
}
