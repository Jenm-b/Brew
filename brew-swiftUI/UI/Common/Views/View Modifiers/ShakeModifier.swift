//
//  ShakeModifier.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 04/12/2022.
//

import SwiftUI

struct ShakeModifier: ViewModifier {
    let isShaking: Bool

    private static func randomize(interval: TimeInterval, withVariance variance: Double) -> TimeInterval {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random
    }

    private let rotateAnimation = Animation
        .easeInOut(
            duration: ShakeModifier.randomize(
                interval: 0.14,
                withVariance: 0.025
            )
        )
        .repeatForever(autoreverses: true)

    private let bounceAnimation = Animation
        .easeInOut(
            duration: ShakeModifier.randomize(
                interval: 0.18,
                withVariance: 0.025
            )
        )
        .repeatForever(autoreverses: true)

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(isShaking ? 2.0 : 0))
            .animation(isShaking ? rotateAnimation: .default, value: isShaking)
            .offset(x: 0, y: isShaking ? 2.0 : 0)
            .animation(isShaking ? rotateAnimation: .default, value: isShaking)
    }
}
