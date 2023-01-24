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
                VStack {
                    ZStack(alignment: .bottom) {
                        Image(configuration.imageName)
                            .resizable()
                            .scaledToFill()
                        Text(configuration.primary)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(width: geo.size.width, alignment: .leading)
                            .background(.ultraThinMaterial)
                    }
                    .frame(minHeight: geo.size.height * 0.5)
                    .frame(width: geo.size.width)
                }
                Spacer(minLength: Padding.item)
                VStack(alignment: .leading, spacing: Padding.item)  {
                    ForEach(Array(configuration.summaryPoints.enumerated()), id: \.offset) { index, item in
                        CommonImageTextSummary(
                            iconName: "\(index + 1)",
                            primaryText: item.primaryText,
                            secondaryText: item.secondaryText,
                            iconTintColor: .primaryTheme)
                        .symbolRenderingMode(.hierarchical)
                        .symbolVariant(.circle)
                        .symbolVariant(.fill)
                    }
                }
                .padding([.leading, .trailing], Padding.stackGap)
            }
            .scrollIndicators(.hidden)
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct DetailedFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkInformationView(configuration: .instantCoffee)
    }
}
