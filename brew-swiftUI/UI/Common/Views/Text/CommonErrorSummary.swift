//
//  CommonErrorSummary.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 11/11/2022.
//

import SwiftUI

struct CommonErrorSummary: View {
    // MARK: - Properties
    let error: LocalizedError

    // MARK: - Views
    var body: some View {
        CommonImageTextSummary(
            iconName: SFSymbol.warning.title,
            primaryText: "Error",
            secondaryText: error.localizedDescription,
            iconTintColor: .error,
            iconSize: Constants.smallIconSize,
            primaryColor: .error,
            secondaryColor: .error
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.leading], Padding.textGap)
        .clipRoundedRectangle(8, fill: Color.error.opacity(0.2), padding: Padding.textGap)
    }
    
}

struct CommonErrorSummary_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CommonErrorSummary(error: DataServiceError.notDeleted)
            CommonErrorSummary(error: Validation.empty)
            CommonErrorSummary(error: Validation.maxCharacters(10))
            CommonErrorSummary(error: Validation.required)
        }
    }
}
