//
//  Image+Extension.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 15/11/2022.
//

import SwiftUI

enum SFSymbol: String {
    case warningBubble = "exclamationmark.bubble.fill"
    case chevronForward =  "chevron.forward"
    case circle
    case checkmark = "checkmark.circle.fill"
    case plus = "plus.circle.fill"
    case trash =  "trash"
    case mug = "cup.and.saucer"
    case menu = "line.3.horizontal.circle.fill"
    case warning = "exclamationmark.triangle.fill"
    case grid = "square.grid.2x2"
    case list = "list.bullet"
    case sparkles
    case speedometer
    case text = "text.badge.checkmark"
    case friends = "person.2.fill"
    case friend = "person"
    case questionmark
    case hammer
    case cart
    case message
    case pencil = "square.and.pencil"
    case gear = "gearshape.fill"
    case shield
    case theme = "cloud.moon"
    case save = "square.and.arrow.down"
    case tearDrop = "drop.fill"
    case keyboardDown = "keyboard.chevron.compact.down.fill"
    case swift = "swift"

    var title: String {
        self.rawValue
    }
}

extension Image {
    static func system(_ symbol: SFSymbol) -> Self {
        Image(systemName: symbol.title)
    }

    init(symbol: SFSymbol) {
        self.init(systemName: symbol.title)
    }
}

extension Image {
    func clipImage<S: Shape, SS: ShapeStyle, FS: ShapeStyle>(_ shape: S = Circle(), fill: SS, width: CGFloat? = nil, height: CGFloat? = nil, padding: CGFloat = Padding.stackGap, foregroundStyle: FS) -> some View {
        modifier(
            ImageWithFillViewModifier(
                shape: shape,
                fill: fill,
                image: self,
                padding: padding,
                width: width,
                height: height,
                foregroundStyle: foregroundStyle)
        )
    }

    func styleImage<FS: ShapeStyle>(width: CGFloat?, height: CGFloat?, foregroundStyle: FS = .ultraThinMaterial) -> some View {
        modifier(
            ImageWithFrameViewModifier(
                image: self,
                foregroundStyle: foregroundStyle,
                width: width,
                height: height)
        )
    }
}
