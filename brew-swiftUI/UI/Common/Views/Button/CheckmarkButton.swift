//
//  CheckmarkButton.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 16/11/2022.
//

import SwiftUI

struct CheckmarkButton: View {
    // MARK: - Wrapped Properties
    @Binding var isChecked: Bool

    // MARK: - Views
    var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            Image(symbol: isChecked ? .checkmark : .circle)
                .clipImage(
                    fill: Color.systemGroupedBackground,
                    width: Constants.smallIconSize,
                    height: Constants.smallIconSize,
                    padding: 3,
                    foregroundStyle: Color.primaryTheme
                )
                .symbolRenderingMode(.hierarchical)
        }
    }
}

struct CheckmarkButton_Previews: PreviewProvider {

    struct DemoView: View {
        @State var isChecked: Bool

        var body: some View {
            CheckmarkButton(isChecked: $isChecked)
        }
    }

    static var previews: some View {
        VStack(spacing: 30) {
            DemoView(isChecked: true)
            DemoView(isChecked: false)
        }
        .background(.teal)
    }
}
