//
//  View+Extension.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 15/11/2022.
//

import SwiftUI

// MARK: - Shape View Modifiers
extension View {
    func customClipShape<S: Shape>(_ shape: S) -> some View {
        modifier(
            ClipShapeWithNoFillViewModifier(shape: shape))
    }

    func customClipShape<S: Shape, SS: ShapeStyle>(_ shape: S, fill: SS, padding: CGFloat = 0) -> some View {
        modifier(
            ClipShapeWithFillViewModifier(
                shape: shape,
                fill: fill,
                padding: padding)
        )
    }

    func clipCircle<SS: ShapeStyle>(fill: SS, constrainGestures: Bool = true, padding: CGFloat = 0) -> some View {
        customClipShape(
            Circle(),
            fill: fill,
            padding: padding
        )
    }

    func clipRoundedRectangle<SS: ShapeStyle>(_ cornerRadius: CGFloat = Constants.iconCornerRadius, cornerStyle: RoundedCornerStyle = .circular, fill: SS, padding: CGFloat = 0) -> some View {
        customClipShape(
            RoundedRectangle(cornerRadius: cornerRadius, style: cornerStyle),
            fill: fill,
            padding: padding
        )
    }
}

// MARK: - Text View Modifiers
extension View {
    func primaryStyle(color: Color = .label) -> some View {
        modifier(Primary(color: color))
    }

    func secondaryStyle(color: Color = .secondaryLabel) -> some View {
        modifier(Secondary(color: color))
    }

    func titleStyle(color: Color = .label) -> some View {
        modifier(Title(color: color))
    }
}

// MARK: - Animations
extension View {
    func shaking(isShaking: Bool) -> some View {
        modifier(ShakeModifier(isShaking: isShaking))
    }
}
