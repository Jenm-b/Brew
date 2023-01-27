//
//  DrinkInformationView.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 11/12/2022.
//

import SwiftUI

struct DrinkInformationView: View {
    let configuration: DrinkInformationConfiguration

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: Padding.item) {
                    header(withTitle: configuration.primary, withImageName: configuration.imageName)
                    .frame(minHeight: geo.size.height * 0.5)
                    list(withSummaryPoints: configuration.summaryPoints)
                }
            }
            .background(Color.systemGroupedBackground)
            .scrollIndicators(.hidden)
            .edgesIgnoringSafeArea(.top)
        }
    }

    func header(withTitle title: String, withImageName imageName: String) -> some View {
        ZStack(alignment: .bottom) {
            Image(imageName)
                .resizable()
                .scaledToFill()
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
                .clipShape(Rectangle())
                .padding([.top, .bottom], Padding.stackGap)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.ultraThinMaterial)
        }
    }

    func list(withSummaryPoints summaryPoints: [Summary]) -> some View {
        ForEach(Array(configuration.summaryPoints.enumerated()), id: \.element) { index, summary in
            item(forSummary: summary, atIndex: index)
        }
        .padding([.leading, .trailing], Padding.screen)
    }


    func item(forSummary summary: Summary, atIndex index: Int) -> some View {
        CommonImageTextSummary(
            iconName: "\(index + 1)",
            primaryText: summary.primaryText,
            secondaryText: summary.secondaryText,
            iconTintColor: .primaryTheme)
        .symbolRenderingMode(.hierarchical)
        .symbolVariant(.circle)
        .symbolVariant(.fill)
        .frame(maxWidth: .infinity, alignment: .leading)
        .clipRoundedRectangle(
            Constants.cardRadius,
            fill: Color.secondarySystemGroupedBackground,
            padding: Padding.stackGap
        )
    }
}

struct DetailedFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkInformationView(configuration: .instantCoffee)
    }
}
