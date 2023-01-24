//
//  LabelStyles.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 05/11/2022.
//

import SwiftUI

struct CenteredImageLabelStyle: LabelStyle {
    // MARK: - Properties
    let spacing: CGFloat

    // MARK: - LabelStyle
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: spacing) {
            configuration.icon
            configuration.title
        }
    }

    // MARK: - Initializer
    init(spacing: CGFloat) {
        self.spacing = spacing
    }
}

struct VerticalLabelStyle: LabelStyle {
    // MARK: - Properties
    let spacing: CGFloat

    // MARK: - LabelStyle
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center, spacing: spacing) {
            configuration.icon
            configuration.title
        }
    }

    // MARK: - Initializer
    init(spacing: CGFloat) {
        self.spacing = spacing
    }
}
