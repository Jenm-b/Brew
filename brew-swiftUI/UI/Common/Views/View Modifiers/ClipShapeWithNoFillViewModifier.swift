//
//  ClipShapeWithNoFillViewModifier.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 15/11/2022.
//

import SwiftUI

struct ClipShapeWithNoFillViewModifier<S: Shape>: ViewModifier {
    // MARK: - Properties
    let shape: S

    // MARK: - Shape Style
    func body(content: Content) -> some View {
        content
            .customClipShape(shape)
    }
}
