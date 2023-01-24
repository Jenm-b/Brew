//
//  WelcomeView.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 21/10/2022.
//

import SwiftUI

struct WelcomeView: View {
    // MARK: - Wrapped Properties
    @ScaledMetric private var size: CGFloat = 1

    // MARK: - Properties
    let item: WelcomeConfiguration
    let onTap: () -> ()

    private var containsSummaryPoints: Bool {
        !item.summaryPoints.isEmpty
    }

    // MARK: - Views
    var body: some View {
        VStack {
            Spacer(minLength: Padding.stackGap)
            primaryContent
            Spacer(minLength: Padding.stackGap)
            actionButton
        }
        .padding(Padding.screen)
    }

    @ViewBuilder
    private var primaryContent: some View {
        titleLabel
        if containsSummaryPoints {
            summaryList
        }
    }
}

// MARK: - Sub-Views
private extension WelcomeView {
    var titleLabel: some View {
        Label {
            CommonTitleSummary(
                primaryText: item.primaryText,
                secondaryText: item.secondaryText
            )
        } icon: {
            Image(symbol: item.icon)
                .clipImage(
                    fill: item.iconTint.gradient,
                    width: size * Constants.extraLargeIconSize,
                    height: size * Constants.extraLargeIconSize,
                    foregroundStyle: item.iconForegroundStyle.gradient
                )
                .shadow(
                    color: Strength.mediumToStrong.color.opacity(Constants.shadowAlpha),
                    radius: Constants.iconCornerRadius,
                    x: 5,
                    y: 5
                )
        }
        .labelStyle(.vertical(spacing: Padding.stackGap))
    }

    var summaryList: some View {
        VStack(alignment: .leading, spacing: Padding.stackGap) {
            ForEach(item.summaryPoints, id: \.primaryText) {
                CommonImageTextSummary(
                    iconName: $0.icon!.title,
                    primaryText: $0.primaryText,
                    secondaryText: $0.secondaryText,
                    iconTintColor: $0.iconTint
                )
            }
        }
        .padding(.leading, Padding.screen)
    }

    var actionButton: some View {
        Button(item.buttonText) {
            onTap()
        }
        .buttonStyle(ActionButtonStyle())
        .frame(alignment: .bottom)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static let titleItem = WelcomeConfiguration.drinkTitle
    static let summaryItem = WelcomeConfiguration.drinkKeyFeature

    static var previews: some View {
        Group {
            WelcomeView(item: titleItem, onTap: {
                print("Welcome friend 👯‍♂️")
            } )
            WelcomeView(item: summaryItem, onTap: {
                print("Wow! Lots of good summary points")
            } )
        }
    }
}
