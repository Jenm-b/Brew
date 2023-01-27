//
//  DrinkInformationGallery.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 09/12/2022.
//

import SwiftUI

struct DrinkInformationGallery: View {
    // MARK: - Wrapper Properties
    @State private var isInformationPresented: Bool = false
    @StateObject private var viewModel = DrinkInformationGalleryViewModel()

    // MARK: - Properties
    private let itemBackgroundColors = [
        Color.rustGradient,
        Color.primaryGradient,
        Color.greenGradient
    ]

    let width: CGFloat
    let height: CGFloat

    // MARK: - Views
    var body: some View {
        TabView(selection: $viewModel.selectedIndex) {
            ForEach(0..<viewModel.configurationCount, id: \.self) { count in
                item(forIndex: count)
            }
            .padding([.top, .leading, .trailing], Padding.screen)
        }
        .transition(.asymmetric(insertion: .slide, removal: .scale.combined(with: .opacity)))
        .animation(.default, value: viewModel.selectedIndex)
        .tabViewStyle(.page)
        .frame(height: height * 0.3)
        .onTapGesture {
            isInformationPresented.toggle()
        }
        .onAppear {
            viewModel.startGalleryTransition()
        }
        .onDisappear {
            viewModel.stopGalleryTransition()
        }
        .onChange(of: isInformationPresented) { newValue in
            newValue ? viewModel.stopGalleryTransition() : viewModel.startGalleryTransition()
        }
        .sheet(isPresented: $isInformationPresented) {
            DrinkInformationView(configuration: viewModel.configurationForSelectedIndex)
                .presentationDetents([.large])
        }
    }

    private func item(forIndex index: Int) -> some View {
        ZStack(alignment: .topLeading) {
            itemBackgroundColor(forIndex: index)
            VStack(alignment: .leading, spacing: Padding.textGap) {
                let configuration  = viewModel.configuration(forIndex: index)
                Text(configuration.topic.uppercased())
                    .font(.caption)
                Divider()
                Text(configuration.primary)
                    .font(.headline)
            }
            .frame(width: width * 0.5)
            .padding([.leading, .top], Padding.screen)
            .foregroundColor(.white)
        }
        .cornerRadius(Constants.cardRadius)
        .shadow(radius: 2)
    }

    private func itemBackgroundColor(forIndex index: Int) -> LinearGradient {
        if itemBackgroundColors.indices.contains(index) {
            return itemBackgroundColors[index]
        } else {
            return Color.rustGradient
        }
    }
}

struct DrinkFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            VStack {
                DrinkInformationGallery(width: geo.size.width, height: geo.size.height)
            }
        }
    }
}
