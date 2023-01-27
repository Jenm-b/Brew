//
//  ClipShapeWithFillViewModifier.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 15/11/2022.
//

import SwiftUI

struct ClipShapeWithFillViewModifier<S: Shape, SS: ShapeStyle>: ViewModifier {
    // MARK: - Properties
    let shape: S
    let fill: SS
    let padding: CGFloat

    // MARK: - Shape Style
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .contentShape(.contextMenuPreview, shape)
            .background(
                fill,
                in: shape
            )
    }
}
