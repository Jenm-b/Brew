//
//  ImageWithFillViewModifier.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 15/11/2022.
//

import SwiftUI

struct ImageWithFillViewModifier<S: Shape, SS: ShapeStyle, FS: ShapeStyle>: ViewModifier {
    // MARK: - Properties
    let shape: S
    let fill: SS
    let foregroundStyle: FS
    var image: Image
    let padding: CGFloat
    var width: CGFloat?
    var height: CGFloat?

    init(shape: S, fill: SS, image: Image, padding: CGFloat, width: CGFloat?, height: CGFloat?, foregroundStyle: FS) {
        self.shape = shape
        self.fill = fill
        self.foregroundStyle = foregroundStyle
        self.image = image
        self.padding = padding
        self.width = width
        self.height = height
    }

    // MARK: - Image Style
    func body(content: Content) -> some View {
        return image
            .styleImage(width: width, height: height, foregroundStyle: foregroundStyle)
            .padding(padding)
            .customClipShape(shape, fill: fill)
    }
}
