//
//  ImageWithFrameViewModifier.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 15/11/2022.
//

import SwiftUI

struct ImageWithFrameViewModifier<SS: ShapeStyle>: ViewModifier {
    // MARK: - Properties
    let image: Image
    let foregroundStyle: SS
    let width: CGFloat?
    let height: CGFloat?

    // MARK: - Image Style
    func body(content: Content) -> some View {
        return image
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .foregroundStyle(foregroundStyle)
    }
}
