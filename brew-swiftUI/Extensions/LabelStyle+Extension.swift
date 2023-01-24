//
//  LabelStyle+Extension.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 17/11/2022.
//

import SwiftUI

extension LabelStyle where Self == CenteredImageLabelStyle {
    static func centeredImage(spacing: CGFloat? = nil) -> CenteredImageLabelStyle {
        CenteredImageLabelStyle(spacing: spacing ?? Padding.stackGap)
    }
}

extension LabelStyle where Self == VerticalLabelStyle {
    static func vertical(spacing: CGFloat) -> VerticalLabelStyle {
        VerticalLabelStyle(spacing: spacing)
    }
}
